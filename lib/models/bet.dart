import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamer_oods_flutter_application/models/play.dart';
import 'package:gamer_oods_flutter_application/models/match.dart';

class Bet {
  String id;
  Match match;
  int point;
  double odds;
  double ennemyOdds;
  String teamId;
  String userId;

  Bet(this.id, this.match, this.point, this.teamId, this.userId, this.odds,
      this.ennemyOdds);

  Bet.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc, Match match)
      : id = doc.id,
        point = doc.data()!["point"],
        odds = doc.data()!["odds"],
        ennemyOdds = doc.data()!["ennemyOdds"],
        userId = doc.data()!["userId"],
        teamId = doc.data()!["teamId"],
        match = match;
}
