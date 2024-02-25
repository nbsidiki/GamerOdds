import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamer_oods_flutter_application/models/play.dart';

class Match {
  String id;
  DateTime date;
  bool ended;
  Play team1;
  Play team2;

  Match(this.id, this.date, this.ended, this.team1, this.team2);

  Match.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc, List<Play> listPlay)
      : id = doc.id,
        date = DateTime.fromMillisecondsSinceEpoch(doc.data()!["date"]),
        ended = doc.data()!["ended"],
        team1 = listPlay[0],
        team2 = listPlay[1];
}
