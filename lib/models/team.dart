import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  String id;
  String imageUrl;
  String name;
  int? ranking;

  Team(this.id, this.imageUrl, this.name, this.ranking);

  Team.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        imageUrl = doc.data()!["imageUrl"],
        name = doc.data()!["name"],
        ranking = doc.data()!["ranking"];
}
