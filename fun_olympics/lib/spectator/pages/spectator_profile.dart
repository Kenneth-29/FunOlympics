import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/spectator/model/spectator_model.dart';
import 'package:fun_olympics/spectator/pages/edit_profile.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Profile extends StatefulWidget {
  static const String route = '/userProfile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? user = _auth.currentUser;
  // lSpec mUser = lSpec();
  // DocumentSnapshot variable = _userCol.doc(user.uid).get().then((varible) => null)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          shape: Border(
            bottom: const BorderSide(
              color: Colors.blueAccent,
              width: 2,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.blueAccent),
          leadingWidth: 200.0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Image.asset(
              'images/fo_logo.png',
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const EditProfile()));
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close)),
          ],
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: SizedBox(
            width: 800,
            child: Card(
              child: Column(
                children: [
                  Text(
                    'User Profile',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Username: ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(user!.displayName.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Email: ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(user!.email.toString()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
