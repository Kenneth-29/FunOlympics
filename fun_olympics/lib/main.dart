import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fun_olympics/admin/pages/admin_dashboard.dart';
import 'package:fun_olympics/admin/pages/admin_login.dart';
import 'package:fun_olympics/broadcaster/pages/broadcaster_home.dart';
import 'package:fun_olympics/broadcaster/pages/broadcaster_login.dart';
import 'package:fun_olympics/broadcaster/pages/broadcaster_signup.dart';
import 'package:fun_olympics/landing_page.dart';
import 'package:fun_olympics/spectator/login_as_page.dart';
import 'package:fun_olympics/spectator/pages/spectator_home.dart';
import 'package:fun_olympics/spectator/pages/spectator_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB9wdjee23frVKdUGkBx_8T1PfVPoWGha8",
          authDomain: "funolympics-kenneth.firebaseapp.com",
          projectId: "funolympics-kenneth",
          storageBucket: "funolympics-kenneth.appspot.com",
          messagingSenderId: "540467591067",
          appId: "1:540467591067:web:3aaba2c71e77355717933e"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LandingPage.route,
      routes: {
        LandingPage.route: (context) => const LandingPage(),
        LogAs.route: (context) => const LogAs(),
        // Admin
        AdminLogin.route: (context) => const AdminLogin(),
        AdminDashboard.route: (context) => const AdminDashboard(),
        //Broadcaster
        BroadcasterSignup.route: (context) => const BroadcasterSignup(),
        BroadcasterLogin.route: (context) => const BroadcasterLogin(),
        BroadcasterHome.route: (context) => const BroadcasterHome(),
        //Spectator
        SpectatorLogin.route: (context) => const SpectatorLogin(),
        Home.route: (context) => const Home(),
      },
      title: 'Fun Olympics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const Home(),
    );
  }
}
