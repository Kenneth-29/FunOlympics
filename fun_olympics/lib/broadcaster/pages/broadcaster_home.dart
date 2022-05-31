import 'package:flutter/material.dart';

class BroadcasterHome extends StatefulWidget {
  static const route = '/broadcaster-home';
  const BroadcasterHome({Key? key}) : super(key: key);

  @override
  State<BroadcasterHome> createState() => _BroadcasterHomeState();
}

class _BroadcasterHomeState extends State<BroadcasterHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      child: Text('Broadcaster home'),
    )));
  }
}
