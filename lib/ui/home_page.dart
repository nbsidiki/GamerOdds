import 'package:flutter/material.dart';
import 'package:gamer_oods_flutter_application/theme/colors.dart';
import 'package:gamer_oods_flutter_application/ui/share/matches_card.dart';
import 'package:gamer_oods_flutter_application/ui/share/mes_paris_card.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(48.0), // here the desired height
          child: getAppbar()),
      body: getBody(),
    );
  }

  Widget getAppbar() {
    return Container(
      height: 48,
      width: double.infinity,
      color: primary,
      child: Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              child: Text(
                'Matchs',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: pageIndex == 0 ? black : black.withOpacity(0.5)),
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
                  bottomRight: Radius.circular(10)))),
    );
  }

  Widget getBody() {
    return Stack(
      alignment: Alignment.center,
      children: [
        IndexedStack(
          index: pageIndex,
          children: [
            SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 90),
              child: Wrap(
                  runSpacing: 16,
                  children: List.generate(29, (index) {
                    return MatchesCard();
                  })),
            )),
            SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 90),
              child: Wrap(
                  runSpacing: 16,
                  children: List.generate(29, (index) {
                    return MesParisCard();
                  })),
            )),
          ],
        ),
        Positioned(
            bottom: 24,
            child: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  '358',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  MingCute.diamond_2_line,
                  size: 24,
                )
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
