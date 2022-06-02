import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fun_olympics/spectator/model/spectator_model.dart';
import 'package:fun_olympics/spectator/utils/database_spectator.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String? uid;
String? userEmail;

class AuthUser {
  //Register

  Future<User?> register(
      String name, String country, String email, String password) async {
    await Firebase.initializeApp();
    User? user;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      user = _auth.currentUser;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;

        lSpec myUser = lSpec(
            id: user.uid,
            name: name,
            country: country,
            email: email,
            password: password);

        await SStore.createSpectator(myUser);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists for the email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  //Login

  Future<User?> login(String email, String password) async {
    await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  //Signout

  Future<String> signOut() async {
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);

    uid = null;
    userEmail = null;

    return 'User signed out';
  }
}
