import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamer_oods_flutter_application/theme/colors.dart';

class MatchesCard extends StatefulWidget {
  const MatchesCard({super.key});

  @override
  State<MatchesCard> createState() => _MatchesCardState();
}

class _MatchesCardState extends State<MatchesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)), color: white),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const Text(
            'Le 14/12/24 à 14h30',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "2.32",
                              style: TextStyle(
                                  color: third, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),                            SizedBox(height: 52, width: 52, child: SvgPicture.asset('assets/images/vitality-logo.svg' ),),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Team Vitality",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: black),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("VS",
                  style: TextStyle(
                      fontSize: 16,
                      color: secondary,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 52, width: 52, child: SvgPicture.asset('assets/images/spirit-logo.svg'),),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "2.32",
                            style: TextStyle(
                                color: third, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Team Spirit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: black),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
