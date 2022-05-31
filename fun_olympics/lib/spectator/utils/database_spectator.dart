import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_olympics/spectator/model/spectator_model.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference _spectatorCollection = _db.collection("Spectators");

class SStore {
  static Future createSpectator(lSpec user) async {
    try {
      await _spectatorCollection.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.toString();
    }
  }
}
