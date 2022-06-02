// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';

class lSpec {
  final String id;
  final String name;
  final String country;
  final String email;
  final String password;

  lSpec({
    required this.id,
    required this.name,
    required this.country,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'email': email,
      'password': password,
    };
  }

  lSpec.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()!["id"],
        name = doc.data()!["name"],
        country = doc.data()!["counry"],
        email = doc.data()!["email"],
        password = doc.data()!["password"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'email': email,
      'password': password,
    };
  }
}
