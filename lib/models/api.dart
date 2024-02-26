import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamer_oods_flutter_application/models/bet.dart';
import 'package:gamer_oods_flutter_application/models/globals.dart';
import 'package:gamer_oods_flutter_application/models/match.dart';
import 'package:gamer_oods_flutter_application/models/play.dart';
import 'package:gamer_oods_flutter_application/models/team.dart';

class API {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<List<Match>> getMatchs() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("match")
        .where("date",
            isGreaterThan: DateTime.now().toUtc().millisecondsSinceEpoch)
        .orderBy("date")
        .get();
    return Future.wait(snapshot.docs.map((docSnapshot) async {
      List<Play> listPlays = await API.getPlaysByMatchId(docSnapshot.id);
      return Match.fromDocumentSnapshot(docSnapshot, listPlays);
    }).toList());
  }

  static Future<Match> getMatchById(String matchId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("match").doc(matchId).get();
    List<Play> listPlays = await API.getPlaysByMatchId(snapshot.id);
    return Match.fromDocumentSnapshot(snapshot, listPlays);
  }

  static Future<List<Play>> getPlaysByMatchId(String matchId) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("match").doc(matchId).collection("team").get();

    return Future.wait(snapshot.docs.map((docSnapshot) async {
      Team team =
          await API.getTeamById(docSnapshot.data()["teamId"].toString());
      return Play.fromDocumentSnapshot(docSnapshot, team as Team);
    }).toList());
  }

  static Future<Team> getTeamById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("team").doc(id).get();

    return Team.fromDocumentSnapshot(snapshot);
  }

  static Future<bool> addBet(String matchId, int point, String teamId, double odds,
      double ennemyOdds) async {
    int userPoints = await API.getPointsFromUserId(currentUserId);
    if (userPoints < point) {
      return false;
    }
    final bet = <String, dynamic>{
      "matchId": matchId,
      "point": point,
      "teamId": teamId,
      "userId": currentUserId,
      "odds": odds,
      "ennemyOdds": ennemyOdds,
    };

    return _db.collection("bet").add(bet).then((documentSnapshot) {
      _db.collection("user").doc(currentUserId).update({"point": FieldValue.increment(-1 * point)});
      return true;
    });
  }

  static Future<List<Bet>> getBetsFromUserId(String userId) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("bet").where("userId", isEqualTo: userId).get();
    return Future.wait(snapshot.docs.map((docSnapshot) async {
      Match match = await API.getMatchById(docSnapshot.data()["matchId"]);
      return Bet.fromDocumentSnapshot(docSnapshot, match);
    }).toList());
  }

  

  static Future<int> getPointsFromUserId(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("user").doc(userId).get();
    return snapshot.data()?["point"];
  }

}
