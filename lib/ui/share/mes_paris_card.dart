import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamer_oods_flutter_application/theme/colors.dart';
import 'package:icons_plus/icons_plus.dart';

class MesParisCard extends StatefulWidget {
  const MesParisCard({super.key});

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
              Image.asset('assets/images/cs2logo.png', height: 36, width: 36,),
              SizedBox(width: 10,),
              const Text(
                'Le 14/12/24 à 14h30',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color:black),
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
                            const Text(
                              "2.32",
                              style: TextStyle(
                                  color: third, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 52,
                              width: 52,
                              child: SvgPicture.asset(
                                  'assets/images/vitality-logo.svg'),
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
                                "Team Vitality",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(padding: EdgeInsets.fromLTRB(9, 3, 9, 3), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color:Color(0xffB52323)), child: Text("Défaite", style: TextStyle(color: white, fontWeight: FontWeight.bold),),)
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
                            child: SvgPicture.asset(
                                'assets/images/spirit-logo.svg'),
                          ),
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
                      ),
                      SizedBox(height: 20,),
                        Container(padding: EdgeInsets.fromLTRB(9, 3, 9, 3), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color:Color(0xff4DB23C)), child: Text("Victoire", style: TextStyle(color: white, fontWeight: FontWeight.bold),),)
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Container(width: 160, height: 40, decoration: BoxDecoration(color: secondary, borderRadius: BorderRadius.all(Radius.circular(10)),), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("30", style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 18),),SizedBox(width: 6,), Icon(MingCute.diamond_2_line, size: 24, color: black)]),)
        ]),
      ),
    );
  }
}
