import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/broadcaster/utils/database_broadcaster.dart';
import 'package:fun_olympics/spectator/model/video.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _fkey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _urlCtrl = TextEditingController();

  final _idFN = FocusNode();
  final _titleFN = FocusNode();
  final _descFN = FocusNode();
  final _urlFN = FocusNode();

  bool _isEditing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        _idFN.unfocus();
        _titleFN.unfocus();
        _descFN.unfocus();
        _urlFN.unfocus();
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
                      'Upload a Video',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _idCtrl,
                      // validator: Validation.username,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Video id',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _titleCtrl,
                      // validator: Validation.username,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Video Title',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _descCtrl,
                      // validator: Validation.username,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _urlCtrl,
                      // validator: Validation.username,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'URL',
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
                            child: const Text('Upload Video'),
                            onPressed: () async {
                              if (_fkey.currentState!.validate()) {
                                setState(() {
                                  _isEditing = true;
                                });
                              }

                              Video video = Video(
                                id: _idCtrl.text,
                                title: _titleCtrl.text,
                                description: _descCtrl.text,
                                url: _urlCtrl.text,
                              );
                              await BStore.uploadVid(video);

                              setState(() {
                                _isEditing = false;
                              });
                              if (video != null) {
                                //notify on sucess
                                print('sucess');
                                CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    text: 'Video Uploaded Sucessfully!',
                                    autoCloseDuration: Duration(seconds: 2));
                                _idCtrl.clear();
                                _titleCtrl.clear();
                                _descCtrl.clear();
                                _urlCtrl.clear();
                              }
                            },
                          ),
                        ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
