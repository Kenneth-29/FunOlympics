import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/broadcaster/pages/broadcaster_home.dart';
import 'package:fun_olympics/broadcaster/pages/broadcaster_login.dart';
import 'package:fun_olympics/broadcaster/utils/authentication_broadcaster.dart';

import '../../global/utils/validation.dart';
import '../../landing_page.dart';

class BroadcasterSignup extends StatefulWidget {
  static const route = '/broadcaster-signup';
  const BroadcasterSignup({Key? key}) : super(key: key);

  @override
  State<BroadcasterSignup> createState() => _BroadcasterSignupState();
}

class _BroadcasterSignupState extends State<BroadcasterSignup> {
  final _fkey = GlobalKey<FormState>();
  final _unameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _unameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();

  final _webCtrl = TextEditingController();
  final _summCtrl = TextEditingController();
  final _webFN = FocusNode();
  final _sumFN = FocusNode();

  final _auth = AuthBroadcaster();
  bool _isEditing = false;
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        _unameFocusNode.unfocus();
        _emailFocusNode.unfocus();
        _passFocusNode.unfocus();
        _webFN.unfocus();
        _sumFN.unfocus();
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
                        'Sign Up as Broadcaster',
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Add Portfolio',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _webCtrl,
                      // validator: Validation.useremail,
                      decoration: const InputDecoration(
                        hintText: 'http://example.com',
                        border: OutlineInputBorder(),
                        labelText: 'Website',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      maxLines: 20,
                      controller: _summCtrl,
                      // validator: Validation.useremail,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Summary',
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
                              final User? user =
                                  await _auth.registerBroadcaster(
                                _unameCtrl.text,
                                _emailCtrl.text,
                                _passCtrl.text,
                                status,
                              );
                              setState(() {
                                _isEditing = false;
                              });
                              if (user != null) {
                                Navigator.of(context)
                                    .pushNamed(BroadcasterHome.route);
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
                              BroadcasterLogin.route, (route) => false);
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
