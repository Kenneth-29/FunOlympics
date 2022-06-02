// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';

class lBrod {
  String? id;
  String? name;
  String? email;
  String? password;
  bool? approval;

  lBrod({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.approval,
  });

  lBrod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    approval = json['approval'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'approval': approval,
    };
  }

  lBrod.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()!["id"],
        name = doc.data()!["name"],
        email = doc.data()!["email"],
        password = doc.data()!["password"],
        approval = doc.data()!["approval"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'approval': approval,
    };
  }
}
