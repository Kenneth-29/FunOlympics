import 'package:flutter/material.dart';

class LogAs extends StatelessWidget {
  static const String route = "/log-as";
  const LogAs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Continue as:',
            style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Broadcaster'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Spectator'),
              )
            ],
          ),
        ],
      )),
    );
  }
}
