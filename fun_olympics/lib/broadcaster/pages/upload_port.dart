import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/broadcaster/model/portfolio_model.dart';
import 'package:fun_olympics/broadcaster/utils/database_broadcaster.dart';

class UploadPortfolio extends StatefulWidget {
  const UploadPortfolio({Key? key}) : super(key: key);

  @override
  State<UploadPortfolio> createState() => _UploadPortfolioState();
}

class _UploadPortfolioState extends State<UploadPortfolio> {
  final _fkey = GlobalKey<FormState>();
  final _webCtrl = TextEditingController();
  final _summCtrl = TextEditingController();
  final _sFN = FocusNode();
  final _wFN = FocusNode();

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isEditing = false;

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        _sFN.unfocus();
        _wFN.unfocus();
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
          iconTheme: const IconThemeData(color: Colors.blueAccent),
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Image.asset(
              'images/fo_logo.png',
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close)),
          ],
          backgroundColor: Colors.white,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 200, right: 200, top: 200),
            child: Card(
              child: Form(
                child: ListView(
                  children: [
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
                              child: const Text('Upload Portfolio'),
                              onPressed: () async {
                                if (_fkey.currentState!.validate()) {
                                  setState(() {
                                    _isEditing = true;
                                  });
                                }

                                Portfolio port = Portfolio(
                                    id: user!.uid,
                                    summary: _summCtrl.text,
                                    website: _webCtrl.text);

                                await BStore.uploadPort(port);

                                setState(() {
                                  _isEditing = false;
                                });
                                if (port != null) {
                                  setState(() {
                                    _summCtrl.clear();
                                    _webCtrl.clear();
                                  });
                                }
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
