import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gamer_oods_flutter_application/models/api.dart';
import 'package:gamer_oods_flutter_application/models/bet.dart';
import 'package:gamer_oods_flutter_application/models/globals.dart';
import 'package:gamer_oods_flutter_application/models/play.dart';
import 'package:gamer_oods_flutter_application/models/team.dart';
import 'package:gamer_oods_flutter_application/theme/colors.dart';
import 'package:gamer_oods_flutter_application/ui/parier_page.dart';
import 'package:gamer_oods_flutter_application/ui/share/matches_card.dart';
import 'package:gamer_oods_flutter_application/ui/share/mes_paris_card.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gamer_oods_flutter_application/models/match.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  late StreamController<List<Match>> matchs;
  int countMatchs = 0;
  late StreamController<List<Bet>> bets;
  int countBets = 0;
  late StreamController<int> points;
  late StreamController<List<Bet>> histo;
  int countHisto = 0;
  bool pointInitialized = false;
  Timer? timer;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: primary,
    ));
    points = StreamController<int>();
    FirebaseFirestore.instance
        .collection('user')
        .doc(currentUserId)
        .snapshots()
        .listen((event) {
      points.sink.add(event.data()!["point"]);
    });

    matchs = StreamController<List<Match>>();
    FirebaseFirestore.instance
        .collection("match")
        .where("date",
            isGreaterThan: DateTime.now().toUtc().millisecondsSinceEpoch)
        .orderBy("date")
        .snapshots()
        .listen((event) async {
      countMatchs++;
      int localCount = countMatchs;
      List<Match> tempMatch =
          await Future.wait(event.docs.map((docSnapshot) async {
        Team team1 =
            await API.getTeamById(docSnapshot.data()["team1Id"].toString());
        Team team2 =
            await API.getTeamById(docSnapshot.data()["team2Id"].toString());
        return Match.fromDocumentSnapshot(docSnapshot, team1, team2);
      }).toList());
      if (localCount == countMatchs) {
        matchs.sink.add(tempMatch);
      }
    });

    bets = StreamController<List<Bet>>();
    FirebaseFirestore.instance
        .collection("bet")
        .where("userId", isEqualTo: currentUserId)
        .where("ended", isEqualTo: false)
        .snapshots()
        .listen((event) async {
      countBets++;
      int localCount = countBets;
      List<Bet> tempBet = await Future.wait(event.docs.map((docSnapshot) async {
        Match match =
            await API.getMatchById(docSnapshot.data()["matchId"].toString());
        return Bet.fromDocumentSnapshot(docSnapshot, match);
      }).toList());
      if (localCount == countBets) {
        bets.sink.add(tempBet);
      }
    });

    histo = StreamController<List<Bet>>();
    FirebaseFirestore.instance
        .collection("bet")
        .where("userId", isEqualTo: currentUserId)
        .where("ended", isEqualTo: true)
        .where("win", isNotEqualTo: null)
        .snapshots()
        .listen((event) async {
      countHisto++;
      int localCount = countHisto;
      List<Bet> tempHisto =
          await Future.wait(event.docs.map((docSnapshot) async {
        Match match =
            await API.getMatchById(docSnapshot.data()["matchId"].toString());
        return Bet.fromDocumentSnapshot(docSnapshot, match);
      }).toList());
      if (localCount == countHisto) {
        histo.sink.add(tempHisto);
      }
    });

    timer = Timer.periodic(Duration(seconds: 40), (Timer t) {
      reloadData();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void reloadData() {
    setState(() {
      //points = API.getPointsFromUserId(currentUserId);
      // matchs = API.getMatchs();
      // bets = API.getBetsFromUserId(currentUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(48.0), // here the desired height
          child: Container(
              decoration: const BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: SafeArea(child: getAppbar()))),
      body: SafeArea(child: getBody()),
    );
  }

  Widget getAppbar() {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 4,
              offset: Offset(0, 4), // Shadow position
            ),
          ],
          color: secondary,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        GestureDetector(
          onTap: () {
            setState(() {
              pageIndex = 0;
            });
          },
          child: Text(
            'Matchs',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: pageIndex == 0 ? black : black.withOpacity(0.5)),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              pageIndex = 1;
            });
          },
          child: Text(
            'Mes paris',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: pageIndex == 1 ? black : black.withOpacity(0.5)),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              pageIndex = 2;
            });
          },
          child: Text(
            'Historique',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: pageIndex == 2 ? black : black.withOpacity(0.5)),
          ),
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ))
      ]),
    );
  }

  Widget getBody() {
    return Stack(
      alignment: Alignment.center,
      children: [
        IndexedStack(
          index: pageIndex,
          children: [
            StreamBuilder(
                stream: matchs.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 90),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height - 154),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Wrap(
                                runSpacing: 16,
                                children: List.generate(
                                    snapshot.data?.length ?? 0, (index) {
                                  return Animate(
                                    effects: [
                                      FadeEffect(
                                          delay: countMatchs != 1
                                              ? 200.ms
                                              : index > 8
                                                  ? (200 * 8).ms
                                                  : (200 * index).ms,
                                          duration: 500.ms),
                                      SlideEffect(
                                          delay: countMatchs != 1
                                              ? 200.ms
                                              : index > 8
                                                  ? (200 * 8).ms
                                                  : (200 * index).ms,
                                          duration: 500.ms,
                                          begin: Offset(0, 0.2))
                                    ],
                                    child: GestureDetector(
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: ParierPage(
                                                  (snapshot.data
                                                      as List<Match>)[index],
                                                  await API.getPointsFromUserId(
                                                      currentUserId)),
                                            ),
                                          ).then((val) => val
                                              ? {
                                                  // setState(() {
                                                  //   // matchs = API.getMatchs();
                                                  //   // bets = API.getBetsFromUserId(
                                                  //   //     currentUserId);
                                                  //   // Future.delayed(
                                                  //   //     const Duration(
                                                  //   //         milliseconds: 0), () {
                                                  //   //           API
                                                  //   //     .getPointsFromUserId(
                                                  //   //         currentUserId)
                                                  //   //     .then((value) {
                                                  //   //   points.sink.add(value);
                                                  //   // });
                                                  //   //   //points = API.getPointsFromUserId(currentUserId);
                                                  //   // });

                                                  //   timer?.cancel();
                                                  //   timer = Timer.periodic(
                                                  //       Duration(seconds: 40),
                                                  //       (Timer t) {
                                                  //     reloadData();
                                                  //   });
                                                  // })
                                                }
                                              : null);
                                        },
                                        child: MatchesCard((snapshot.data
                                            as List<Match>)[index])),
                                  );
                                })),
                          ],
                        ),
                      ),
                    ));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("erreur : ${snapshot.error}"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: secondary),
                    );
                  }
                }),
            StreamBuilder(
                stream: bets.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    snapshot.data?.sort((a, b) {
                      return a.match.date.isBefore(b.match.date)
                          ? -1
                          : ((a.match.date.isAfter(b.match.date)) ? 1 : 0);
                    });
                    return SingleChildScrollView(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 90),
                      child: Wrap(
                          runSpacing: 16,
                          children: List.generate(snapshot.data?.length ?? 0,
                              (index) {
                            return Animate(
                              effects: [
                                FadeEffect(
                                    delay: countBets != 1
                                        ? 200.ms
                                        : index > 8
                                            ? (200 * 8).ms
                                            : (200 * index).ms,
                                    duration: 500.ms),
                                SlideEffect(
                                    delay: countBets != 1
                                        ? 200.ms
                                        : index > 8
                                            ? (200 * 8).ms
                                            : (200 * index).ms,
                                    duration: 500.ms,
                                    begin: Offset(0, 0.2))
                              ],
                              child: MesParisCard(
                                  (snapshot.data as List<Bet>)[index]),
                            );
                          })),
                    ));
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text("erreur : ${snapshot.error}"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: secondary),
                    );
                  }
                }),
            StreamBuilder(
                stream: histo.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    snapshot.data?.sort((a, b) {
                      return a.match.date.isBefore(b.match.date)
                          ? -1
                          : ((a.match.date.isAfter(b.match.date)) ? 1 : 0);
                    });
                    return SingleChildScrollView(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 90),
                      child: Wrap(
                          runSpacing: 16,
                          children: List.generate(snapshot.data?.length ?? 0,
                              (index) {
                            return Animate(
                              effects: [
                                FadeEffect(
                                    delay: countHisto != 1
                                        ? 200.ms
                                        : index > 8
                                            ? (200 * 8).ms
                                            : (200 * index).ms,
                                    duration: 500.ms),
                                SlideEffect(
                                    delay: countHisto != 1
                                        ? 200.ms
                                        : index > 8
                                            ? (200 * 8).ms
                                            : (200 * index).ms,
                                    duration: 500.ms,
                                    begin: Offset(0, 0.2))
                              ],
                              child: MesParisCard(
                                  (snapshot.data as List<Bet>)[index]),
                            );
                          })),
                    ));
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text("erreur : ${snapshot.error}"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: secondary),
                    );
                  }
                }),
            Center(
              child: Text("Historique"),
            )
          ],
        ),
        Positioned(
            bottom: 24,
            child: Container(
              width: 210,
              height: 50,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      blurRadius: 4,
                      offset: Offset(0, 4), // Shadow position
                    ),
                  ],
                  color: secondary,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: StreamBuilder(
                  stream: points.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      pointInitialized = true;
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data.toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Icon(MingCute.diamond_2_line,
                                size: 24, color: black)
                          ]);
                    } else {
                      return const Center(
                        child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: third,
                            )),
                      );
                    }
                  }),
            ))
      ],
    );
  }
}
