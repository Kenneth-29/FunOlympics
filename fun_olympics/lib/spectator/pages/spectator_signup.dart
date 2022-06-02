import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/landing_page.dart';
import 'package:fun_olympics/spectator/pages/spectator_home.dart';
import 'package:fun_olympics/spectator/pages/spectator_login.dart';
import 'package:fun_olympics/spectator/utils/authentication.dart';

import '../../global/utils/validation.dart';

class SpectatorRegister extends StatefulWidget {
  static const route = '/spectator-register';
  const SpectatorRegister({Key? key}) : super(key: key);

  @override
  State<SpectatorRegister> createState() => _SpectatorRegisterState();
}

class _SpectatorRegisterState extends State<SpectatorRegister> {
  final _fkey = GlobalKey<FormState>();
  final _unameCtrl = TextEditingController();
  final _countryCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _unameFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();

  final _auth = AuthUser();
  bool _isEditing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        _unameFocusNode.unfocus();
        _countryFocusNode.unfocus();
        _emailFocusNode.unfocus();
        _passFocusNode.unfocus();
      }),
      child: Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          shape: Border(
            bottom: const BorderSide(
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
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _unameCtrl,
                      validator: Validation.username,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _countryCtrl,
                      validator: Validation.username,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Country',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _emailCtrl,
                      validator: Validation.useremail,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Email',
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
                            child: const Text('SignUp'),
                            onPressed: () async {
                              if (_fkey.currentState!.validate()) {
                                setState(() {
                                  _isEditing = true;
                                });
                              }
                              final User? user = await _auth.register(
                                _unameCtrl.text,
                                _countryCtrl.text,
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
                      const Text('Already have an account?'),
                      TextButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              SpectatorLogin.route, (route) => false);
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
