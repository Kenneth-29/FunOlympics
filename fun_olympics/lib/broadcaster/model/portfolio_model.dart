import 'package:cloud_firestore/cloud_firestore.dart';

class Portfolio {
  final String summary;
  final String name;

  Portfolio({
    required this.summary,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'summary': summary,
      'name': name,
    };
  }

  Portfolio.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : summary = doc.data()!["summary"],
        name = doc.data()!["name"];

  Map<String, dynamic> toJson() {
    return {
      'summary': summary,
      'name': name,
    };
  }
}
