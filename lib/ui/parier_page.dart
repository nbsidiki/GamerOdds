import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamer_oods_flutter_application/models/api.dart';
import 'package:gamer_oods_flutter_application/models/globals.dart';
import 'package:gamer_oods_flutter_application/theme/colors.dart';
import 'package:gamer_oods_flutter_application/ui/home_page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:gamer_oods_flutter_application/models/match.dart';
import 'package:intl/intl.dart';
import 'package:jovial_svg/jovial_svg.dart';

class ParierPage extends StatefulWidget {
  final Match match;
  final int points;

  const ParierPage(this.match, this.points, {Key? key}) : super(key: key);

  @override
  State<ParierPage> createState() => _ParierPageState();
}

class _ParierPageState extends State<ParierPage> {
  int indexCurrentTeam = 0;
  final pointValue = TextEditingController();

  @override
  void dispose() {
    pointValue.dispose();
    super.dispose();
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
        body: getBody());
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
      child: Stack(children: [
        const SizedBox(
          height: 48,
          width: double.infinity,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Parier",
                  style: TextStyle(
                      color: black, fontWeight: FontWeight.bold, fontSize: 16),
                )
              ]),
        ),
        Positioned(
          top: 12,
          left: 32,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context, false);
              },
              child: const Icon(
                MingCute.left_line,
                size: 24,
                color: black,
              )),
        )
      ]),
    );
  }

  Widget getBody() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/cs2logo.png',
                          height: 36,
                          width: 36,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy à HH:mm')
                              .format(widget.match.date),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (indexCurrentTeam == 1) {
                                indexCurrentTeam = 0;
                              } else {
                                indexCurrentTeam = 1;
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width / 2 - 24,
                            height: MediaQuery.of(context).size.width / 2 - 24,
                            decoration: BoxDecoration(
                              color: indexCurrentTeam == 1
                                  ? const Color(0xff37B523)
                                  : indexCurrentTeam == 0
                                      ? white
                                      : const Color(0xffB52323),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child:
                                  //SvgPicture.asset('assets/images/vitality-logo.svg'),
                                  Center(
                                child: SizedBox(
                                  height: 52,
                                  width: 52,
                                  child: widget.match.team1.team.imageUrl
                                          .contains(".svg")
                                      ? ScalableImageWidget.fromSISource(
                                          si: ScalableImageSource
                                              .fromSvgHttpUrl(Uri.parse(widget
                                                  .match.team1.team.imageUrl)))
                                      : Image.network(
                                          widget.match.team1.team.imageUrl),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (indexCurrentTeam == 2) {
                                indexCurrentTeam = 0;
                              } else {
                                indexCurrentTeam = 2;
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width / 2 - 24,
                            height: MediaQuery.of(context).size.width / 2 - 24,
                            decoration: BoxDecoration(
                              color: indexCurrentTeam == 2
                                  ? const Color(0xff37B523)
                                  : indexCurrentTeam == 0
                                      ? white
                                      : const Color(0xffB52323),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child:
                                  //SvgPicture.asset('assets/images/spirit-logo.svg'),
                                  Center(
                                child: SizedBox(
                                  height: 52,
                                  width: 52,
                                  child: widget.match.team2.team.imageUrl
                                          .contains(".svg")
                                      ? ScalableImageWidget.fromSISource(
                                          si: ScalableImageSource
                                              .fromSvgHttpUrl(Uri.parse(widget
                                                  .match.team2.team.imageUrl)))
                                      : Image.network(
                                          widget.match.team2.team.imageUrl),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 2 - 24,
                            child: Column(
                              children: [
                                AnimatedDefaultTextStyle(
                                  child:
                                      Text(widget.match.team1.odds.toString()),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      fontFamily: 'BricolageGrotesque',
                                      color: indexCurrentTeam == 1
                                          ? const Color(0xff37B523)
                                          : indexCurrentTeam == 0
                                              ? third
                                              : const Color(0xffB52323)),
                                  duration: const Duration(milliseconds: 300),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  widget.match.team1.team.name.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: white),
                                ),
                              ],
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width / 2 - 24,
                            child: Column(
                              children: [
                                AnimatedDefaultTextStyle(
                                  child:
                                      Text(widget.match.team2.odds.toString()),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      fontFamily: 'BricolageGrotesque',
                                      color: indexCurrentTeam == 2
                                          ? const Color(0xff37B523)
                                          : indexCurrentTeam == 0
                                              ? third
                                              : const Color(0xffB52323)),
                                  duration: const Duration(milliseconds: 300),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  widget.match.team2.team.name.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: white),
                                ),
                              ],
                            ))
                      ],
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            blurRadius: 4,
                            offset: Offset(0, 4), // Shadow position
                          ),
                        ],
                      ),
                      width: 290,
                      height: 54,
                      child: TextField(
                        onChanged: (value) {
                          if (int.parse(pointValue.text) > widget.points) {
                            pointValue.text = widget.points.toString();
                          }
                          setState(() {});
                        },
                        controller: pointValue,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          // for below version 2 use this
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          // for version 2 and greater youcan also use this
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                            color: black, fontWeight: FontWeight.bold),
                        cursorColor: third,
                        decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none),
                            hintText: 'Votre mise',
                            hintStyle: TextStyle(
                                fontFamily: 'BricolageGrotesque',
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: black.withOpacity(0.4))),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        widget.points.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondary),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(MingCute.diamond_2_line, size: 24, color: secondary),
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () async {
                          if (pointValue.text.isNotEmpty &&
                              indexCurrentTeam != 0) {
                            if (indexCurrentTeam == 1) {
                              API
                                  .addBet(
                                      widget.match.id,
                                      int.parse(pointValue.text),
                                      "1",
                                      widget.match.team1.odds,
                                      widget.match.team2.odds)
                                  .then(
                                (value) {
                                  Navigator.pop(context, true);
                                },
                              );
                            }
                            if (indexCurrentTeam == 2) {
                              API
                                  .addBet(
                                      widget.match.id,
                                      int.parse(pointValue.text),
                                      "2",
                                      widget.match.team2.odds,
                                      widget.match.team1.odds)
                                  .then(
                                (value) {
                                  Navigator.pop(context, true);
                                },
                              );
                            }
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 54,
                          width: 170,
                          decoration: BoxDecoration(
                            color: (indexCurrentTeam != 0 &&
                                    pointValue.text.isNotEmpty)
                                ? secondary
                                : Color(0xffB7B7B7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                blurRadius: 4,
                                offset: Offset(0, 4), // Shadow position
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Parier",
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ]),
                        ),
                      )
                    ])
                  ],
                ),
              )),
        ])

        // Positioned(
        //   bottom: 0,
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         height: 16,
        //       ),
        //       Container(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(20.0),
        //           color: white,
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black.withOpacity(0.16),
        //               blurRadius: 4,
        //               offset: Offset(0, 4), // Shadow position
        //             ),
        //           ],
        //         ),
        //         width: 290,
        //         height: 54,
        //         child: TextField(
        //           keyboardType: TextInputType.number,
        //           inputFormatters: <TextInputFormatter>[
        //             // for below version 2 use this
        //             FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        //             // for version 2 and greater youcan also use this
        //             FilteringTextInputFormatter.digitsOnly
        //           ],
        //           style: TextStyle(color: black, fontWeight: FontWeight.bold),
        //           cursorColor: third,
        //           decoration: InputDecoration(
        //               isDense: true,
        //               border: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(20.0),
        //                   borderSide: BorderSide.none),
        //               hintText: 'Votre mise',
        //               hintStyle: TextStyle(
        //                   fontFamily: 'BricolageGrotesque',
        //                   fontSize: 20,
        //                   fontWeight: FontWeight.normal,
        //                   color: black.withOpacity(0.4))),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 16,
        //       ),
        //       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //         Text(
        //           '358',
        //           style: TextStyle(
        //               fontSize: 18,
        //               fontWeight: FontWeight.bold,
        //               color: secondary),
        //         ),
        //         SizedBox(
        //           width: 6,
        //         ),
        //         Icon(MingCute.diamond_2_line, size: 24, color: secondary),
        //         SizedBox(width: 12),
        //         AnimatedContainer(
        //           duration: const Duration(milliseconds: 300),
        //           curve: Curves.easeInOut,
        //           height: 54,
        //           width: 170,
        //           decoration: BoxDecoration(
        //             color:
        //                 indexCurrentTeam == 0 ? Color(0xffB7B7B7) : secondary,
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.black.withOpacity(0.16),
        //                 blurRadius: 4,
        //                 offset: Offset(0, 4), // Shadow position
        //               ),
        //             ],
        //             borderRadius: BorderRadius.circular(20.0),
        //           ),
        //           child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Parier",
        //                   style: TextStyle(
        //                       color: white,
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: 20),
        //                 )
        //               ]),
        //         )
        //       ])
        //     ],
        //   ),
        // )
      ],
    );
  }
}
