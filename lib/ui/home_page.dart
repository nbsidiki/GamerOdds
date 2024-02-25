import 'package:flutter/material.dart';
import 'package:gamer_oods_flutter_application/models/api.dart';
import 'package:gamer_oods_flutter_application/models/bet.dart';
import 'package:gamer_oods_flutter_application/models/globals.dart';
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
  late Future<List<Match>> matchs;
  late Future<List<Bet>> bets;

  @override
  void initState() {
    matchs = API.getMatchs();
    bets = API.getBetsFromUserId(currentUserId);
    super.initState();
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
          )
        ]),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 4,
                offset: Offset(0, 4), // Shadow position
              ),
            ],
            color: secondary,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))));
  }

  Widget getBody() {
    return Stack(
      alignment: Alignment.center,
      children: [
        IndexedStack(
          index: pageIndex,
          children: [
            FutureBuilder(
                future: matchs,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 90),
                      child: Wrap(
                          runSpacing: 16,
                          children: List.generate(snapshot.data?.length ?? 0,
                              (index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: ParierPage((snapshot.data
                                          as List<Match>)[index]),
                                    ),
                                  ).then((val) => val
                                      ? {
                                          setState(() {
                                            matchs = API.getMatchs();
                                            bets = API.getBetsFromUserId(
                                                currentUserId);
                                          })
                                        }
                                      : null);
                                },
                                child: MatchesCard(
                                    (snapshot.data as List<Match>)[index]));
                          })),
                    ));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("erreur : ${snapshot.error}"),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: secondary),
                    );
                  }
                }),
            FutureBuilder(
                future: bets,
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
                            return MesParisCard(
                                (snapshot.data as List<Bet>)[index]);
                          })),
                    ));
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text("erreur : ${snapshot.error}"),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: secondary),
                    );
                  }
                }),
          ],
        ),
        Positioned(
            bottom: 24,
            child: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  '358',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(MingCute.diamond_2_line, size: 24, color: black)
              ]),
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
            ))
      ],
    );
  }
}
