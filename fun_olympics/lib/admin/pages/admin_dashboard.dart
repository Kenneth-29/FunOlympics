import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/admin/pages/admin_login.dart';
import 'package:fun_olympics/admin/pages/view_port.dart';
import 'package:fun_olympics/admin/utils/authentication_admin.dart';
import 'package:fun_olympics/broadcaster/model/broadcaster_model.dart';

class AdminDashboard extends StatefulWidget {
  static const String route = '/dashboard';
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _auth = AuthAdmin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const Border(
            // ignore: prefer_const_constructors
            bottom: BorderSide(
              color: Colors.blueAccent,
              width: 2,
            ),
          ),
          leadingWidth: 200.0,
          iconTheme: const IconThemeData(color: Colors.blueAccent),
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Image.asset(
              'images/fo_logo.png',
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _auth.signOutAdmin();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AdminLogin.route, (route) => false);
              },
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder<List<lBrod>>(
            stream: getBroadcasters(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final broadcasters = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: ListView(
                    children: broadcasters.map(buildUsers).toList(),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Widget buildUsers(lBrod user) => GestureDetector(
        child: InkWell(
          highlightColor: Colors.deepPurple,
          hoverColor: Colors.green,
          enableFeedback: true,
          excludeFromSemantics: true,
          child: ListTile(
            shape: const Border(
              bottom: BorderSide(color: Colors.blueAccent),
            ),
            leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(user.name.toString()),
            subtitle: Text(user.email.toString()),
          ),
        ),
        onTap: () {
          viewPort(context, user);
        },
      );

  Stream<List<lBrod>> getBroadcasters() => FirebaseFirestore.instance
      .collection('Broadcasters')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => lBrod.fromJson(doc.data())).toList());

  void viewPort(BuildContext context, lBrod broadcaster) {
    //naviagto to push to portfolio view page
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ViewPorfolio(broadcaster: broadcaster)));
  }
}
