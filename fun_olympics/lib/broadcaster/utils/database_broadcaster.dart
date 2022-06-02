import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_olympics/broadcaster/model/broadcaster_model.dart';
import 'package:fun_olympics/broadcaster/model/portfolio_model.dart';
import 'package:fun_olympics/spectator/model/video.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference _broadcasterCollection =
    _db.collection("Broadcasters");
final CollectionReference _videosCollection = _db.collection("videos");

class BStore {
  static Future createBroadcaster(lBrod user) async {
    try {
      await _broadcasterCollection.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  static Future uploadPort(Portfolio portfolio) async {
    try {
      await _broadcasterCollection.doc(portfolio.id).set(portfolio.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  // static Future uploadPort(Portfolio portfolio) async {
  //   try {
  //     await _broadcasterCollection.doc(user.id)
  //   } catch (e) {
  //   }
  // }

  static Future uploadVid(Video vid) async {
    try {
      await _videosCollection.doc(vid.id).set(vid.toJson());
    } catch (e) {
      return e.toString();
    }
  }
}
