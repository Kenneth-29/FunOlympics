import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final User? user = _auth.currentUser;

  final _fkey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
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
                // update user profile and return to profile view
                user!.updateDisplayName(_nameCtrl.text);
                user!.updateEmail(_emailCtrl.text);
              },
              icon: const Icon(Icons.check)),
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
                    TextField(
                      controller: _nameCtrl,
                      decoration: InputDecoration(hintText: user!.displayName),
                    )
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
                    TextField(
                      controller: _nameCtrl,
                      decoration: InputDecoration(hintText: user!.email),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
