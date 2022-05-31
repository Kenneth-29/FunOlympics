import 'package:flutter/material.dart';

class BroadcasterSignup extends StatefulWidget {
  static const route = '/broadcaster-signup';
  const BroadcasterSignup({Key? key}) : super(key: key);

  @override
  State<BroadcasterSignup> createState() => _BroadcasterSignupState();
}

class _BroadcasterSignupState extends State<BroadcasterSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Signup'),
        ),
      ),
    );
  }
}
