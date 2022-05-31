import 'package:cloud_firestore/cloud_firestore.dart';

class VideoUp {
  final String title;
  final String desc;
  final String link;

  VideoUp({
    required this.title,
    required this.desc,
    required this.link,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'link': link,
    };
  }

  VideoUp.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : title = doc.data()!["title"],
        desc = doc.data()!["desc"],
        link = doc.data()!["link"];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'desc': desc,
      'link': link,
    };
  }
}
