import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamer_oods_flutter_application/models/team.dart';

class Play {
  String id;
  double odds;
  int teamId;
  bool? win;
  Team team;

  Play(this.id, this.odds, this.teamId, this.win, this.team);

  Play.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc, Team team)
      : id = doc.id,
        odds = doc.data()!["odds"],
        teamId = doc.data()!["teamId"],
        win = doc.data()!["win"],
        team = team;
}
