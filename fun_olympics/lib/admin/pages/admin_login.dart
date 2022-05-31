import 'package:flutter/material.dart';
import 'package:fun_olympics/admin/pages/admin_dashboard.dart';
import 'package:fun_olympics/admin/utils/authentication_admin.dart';
import 'package:fun_olympics/global/utils/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminLogin extends StatefulWidget {
  static const String route = '/admin-login';
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _fkey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _auth = AuthAdmin();
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
          shape: Border(
            bottom: const BorderSide(
              color: Colors.blueAccent,
              width: 2,
            ),
          ),
          leadingWidth: 200.0,
          leading: Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Image.asset(
              'images/fo_logo.png',
            ),
          ),
          backgroundColor: Colors.white,
        ),
        // backgroundColor: Colors.blueAccent[700],
        body: Container(
          color: Colors.blueAccent[700],
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(100),
            child: Form(
              key: _fkey,
              child: Card(
                elevation: 5,
                shadowColor: Colors.blueGrey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 80),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Admin Portal',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
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
                      Container(
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
                              final User? admin = await _auth.loginAdmin(
                                _emailCtrl.text,
                                _passCtrl.text,
                              );
                              setState(() {
                                _isEditing = false;
                              });
                              if (admin != null) {
                                Navigator.of(context)
                                    .pushNamed(AdminDashboard.route);
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
