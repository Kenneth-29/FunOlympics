import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/spectator/pages/spectator_home.dart';
import 'package:fun_olympics/spectator/pages/spectator_signup.dart';
import 'package:fun_olympics/spectator/utils/authentication.dart';

import '../../global/utils/validation.dart';
import '../../landing_page.dart';

class SpectatorLogin extends StatefulWidget {
  static const String route = '/spectator-login';
  const SpectatorLogin({Key? key}) : super(key: key);

  @override
  State<SpectatorLogin> createState() => _SpectatorLoginState();
}

class _SpectatorLoginState extends State<SpectatorLogin> {
  final _fkey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();

  final _auth = AuthUser();
  bool _isEditing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        _emailFocusNode.unfocus();
        _passFocusNode.unfocus();
      }),
      child: Scaffold(
        appBar: AppBar(
          shape: const Border(
            bottom: BorderSide(
              color: Colors.blueAccent,
              width: 2,
            ),
          ),
          leadingWidth: 200.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(LandingPage.route, (route) => false);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Image.asset(
                'images/fo_logo.png',
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 200, right: 200, top: 200),
            child: Form(
              key: _fkey,
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Welcome To FunOlympics',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _emailCtrl,
                      validator: Validation.useremail,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      validator: Validation.userpassword,
                      obscureText: true,
                      controller: _passCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isEditing
                      ? const LinearProgressIndicator()
                      : Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: const Text('Login'),
                            onPressed: () async {
                              if (_fkey.currentState!.validate()) {
                                setState(() {
                                  _isEditing = true;
                                });
                              }
                              final User? user = await _auth.login(
                                _emailCtrl.text,
                                _passCtrl.text,
                              );
                              setState(() {
                                _isEditing = false;
                              });
                              if (user != null) {
                                Navigator.of(context).pushNamed(Home.route);
                              }
                            },
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Don\'t have an account?'),
                      TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              SpectatorRegister.route, (route) => false);
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
