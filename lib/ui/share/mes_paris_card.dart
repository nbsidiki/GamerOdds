import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamer_oods_flutter_application/models/bet.dart';
import 'package:gamer_oods_flutter_application/theme/colors.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:jovial_svg/jovial_svg.dart';

class MesParisCard extends StatefulWidget {
  final Bet bet;

  const MesParisCard(this.bet, {Key? key}) : super(key: key);

  @override
  State<MesParisCard> createState() => _MesParisCardState();
}

class _MesParisCardState extends State<MesParisCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)), color: white),
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
                DateFormat('dd/MM/yyyy à HH:mm').format(widget.bet.match.date),
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
                              widget.bet.teamId == widget.bet.match.team1.id
                                  ? widget.bet.odds.toString()
                                  : widget.bet.ennemyOdds.toString(),
                              style: const TextStyle(
                                  color: third, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 52,
                              width: 52,
                              child: widget.bet.match.team1.imageUrl
                                      .contains(".svg")
                                  ? ScalableImageWidget.fromSISource(
                                      si: ScalableImageSource.fromSvgHttpUrl(
                                          Uri.parse(widget
                                              .bet.match.team1.imageUrl)))
                                  : Image.network(
                                      widget.bet.match.team1.imageUrl),
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
                                widget.bet.match.team1.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(9, 3, 9, 3),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: widget.bet.teamId == widget.bet.match.team1.id
                                  ? Color(0xff4DB23C)
                                  : Color(0xffB52323)),
                          child: Text(
                            widget.bet.teamId == widget.bet.match.team1.id ? "Victoire" : "Défaite",
                            style: TextStyle(
                                color: white, fontWeight: FontWeight.bold),
                          ),
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
                            child: widget.bet.match.team2.imageUrl
                                    .contains(".svg")
                                ? ScalableImageWidget.fromSISource(
                                    si: ScalableImageSource.fromSvgHttpUrl(
                                        Uri.parse(widget
                                            .bet.match.team2.imageUrl)))
                                : Image.network(
                                    widget.bet.match.team2.imageUrl),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.bet.teamId == widget.bet.match.team1.id
                                ? widget.bet.odds.toString()
                                : widget.bet.ennemyOdds.toString(),
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
                              widget.bet.match.team2.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(9, 3, 9, 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: widget.bet.teamId == widget.bet.match.team2.id
                                ? Color(0xff4DB23C)
                                : Color(0xffB52323)),
                        child: Text(
                          widget.bet.teamId == widget.bet.match.team2.id ? "Victoire" : "Défaite",
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 160,
            height: 40,
            decoration: BoxDecoration(
              color: widget.bet.win == null ? secondary : widget.bet.win == true  ? Color(0xff4DB23C) : Color(0xffB52323),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                widget.bet.point.toString(),
                style: TextStyle(
                    color: black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                width: 6,
              ),
              Icon(MingCute.diamond_2_line, size: 24, color: black)
            ]),
          )
        ]),
      ),
    );
  }
}
