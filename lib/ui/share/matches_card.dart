import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamer_oods_flutter_application/theme/colors.dart';
import 'package:gamer_oods_flutter_application/models/match.dart';
import 'package:intl/intl.dart';
import 'package:jovial_svg/jovial_svg.dart';

class MatchesCard extends StatefulWidget {
  final Match match;

  const MatchesCard(this.match, {Key? key}) : super(key: key);

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
      child: Animate(
        effects: [FadeEffect(delay: 100.ms, duration: 600.ms)],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cs2logo.png',
                  height: 36,
                  width: 36,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('dd/MM/yyyy à HH:mm').format(widget.match.date),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, color: black),
                ),
              ],
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
                              Text(
                                widget.match.team1Odds.toString(),
                                style: const TextStyle(
                                    color: third, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                height: 52,
                                width: 52,
                                child: widget.match.team1.imageUrl
                                        .contains(".svg")
                                    ? ScalableImageWidget.fromSISource(
                                        si: ScalableImageSource.fromSvgHttpUrl(
                                            Uri.parse(widget
                                                .match.team1.imageUrl)))
                                    : Image.network(
                                        widget.match.team1.imageUrl),
                                // SvgPicture.asset(
                                //     'assets/images/vitality-logo.svg'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.match.team1.name.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
                            SizedBox(
                              height: 52,
                              width: 52,
                              child: widget.match.team2.imageUrl
                                      .contains(".svg")
                                  ? ScalableImageWidget.fromSISource(
                                      si: ScalableImageSource.fromSvgHttpUrl(
                                          Uri.parse(
                                              widget.match.team2.imageUrl)))
                                  : Image.network(
                                      widget.match.team2.imageUrl),
                              // SvgPicture.asset(
                              //     'assets/images/spirit-logo.svg'),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              widget.match.team2Odds.toString(),
                              style: const TextStyle(
                                  color: third, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.match.team2.name.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
      ),
    );
  }
}
