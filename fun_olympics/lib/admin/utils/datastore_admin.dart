import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_olympics/broadcaster/model/broadcaster_model.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference _broadcasterCollection =
    _db.collection("Broadcasters");

class AdminApprove {
  static Future approveBroadcaster(lBrod user) async {
    try {
      await _broadcasterCollection.doc(user.id).update(user.toMap());
    } catch (e) {
      return e.toString();
    }
  }
}
