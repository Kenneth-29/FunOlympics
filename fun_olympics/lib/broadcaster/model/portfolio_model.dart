import 'package:cloud_firestore/cloud_firestore.dart';

class Portfolio {
  String? id;
  String? summary;
  String? website;

  Portfolio({
    required this.id,
    required this.summary,
    required this.website,
  });

  Portfolio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    summary = json['summary'];
    website = json['website'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'summary': summary,
      'name': website,
    };
  }

  Portfolio.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()!["id"],
        summary = doc.data()!["summary"],
        website = doc.data()!["website"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'summary': summary,
      'website': website,
    };
  }
}
