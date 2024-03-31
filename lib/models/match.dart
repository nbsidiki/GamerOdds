import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamer_oods_flutter_application/models/play.dart';
import 'package:gamer_oods_flutter_application/models/team.dart';

class Match {
  String id;
  DateTime date;
  bool ended;
  Team team1;
  Team team2;
  double team1Odds;
  double team2Odds;
  String? winner;

  Match(this.id, this.date, this.ended, this.team1, this.team2, this.team1Odds, this.team2Odds, this.winner);

  Match.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc, Team team1, Team team2)
      : id = doc.id,
        date = DateTime.fromMillisecondsSinceEpoch(doc.data()!["date"]),
        ended = doc.data()!["ended"],
        team1Odds = doc.data()!["team1odds"],
        team2Odds = doc.data()!["team1odds"],
        winner = doc.data()!["winner"],
        team1 = team1,
        team2 = team2;

}
