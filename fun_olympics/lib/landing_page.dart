import 'package:flutter/material.dart';
import 'package:fun_olympics/broadcaster/pages/broadcaster_login.dart';
import 'package:fun_olympics/spectator/pages/spectator_login.dart';

class LandingPage extends StatelessWidget {
  static const String route = '/landing-page';
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/img.jpg"), fit: BoxFit.cover),
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to FunOlympics',
              style: TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'The home of sports entertainent from the comfort of your home or \n anywhere in the world.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            const Text(
              'Continue as:',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent[700])),
                  onPressed: () {
                    Navigator.of(context).pushNamed(BroadcasterLogin.route);
                  },
                  child: const Text('Broadcaster'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent[700])),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SpectatorLogin.route);
                  },
                  child: const Text('Spectator'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
