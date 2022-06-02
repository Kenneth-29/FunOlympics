import 'package:flutter/material.dart';
import 'package:fun_olympics/broadcaster/pages/broadcaster_login.dart';
import 'package:fun_olympics/spectator/pages/spectator_login.dart';

class LogAs extends StatelessWidget {
  static const String route = '/log_as';
  const LogAs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          const Text(
            'Continue as:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ElevatedButton(
                child: const Text('Spectator'),
                onPressed: () {
                  Navigator.of(context).pushNamed(SpectatorLogin.route);
                },
              ),
              ElevatedButton(
                child: const Text('Broadcaster'),
                onPressed: () {
                  Navigator.of(context).pushNamed(BroadcasterLogin.route);
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
