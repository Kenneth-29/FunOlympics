// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/broadcaster/model/broadcaster_model.dart';

class ViewPorfolio extends StatefulWidget {
  final lBrod broadcaster;
  const ViewPorfolio({required this.broadcaster});

  @override
  State<ViewPorfolio> createState() => _ViewPorfolioState();
}

class _ViewPorfolioState extends State<ViewPorfolio> {
  bool _isAproved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: SizedBox(
          width: 800,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    '${widget.broadcaster.name} Portfolio',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Broadcaster Name: ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text('${widget.broadcaster.name}'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Broadcaster email: ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text('${widget.broadcaster.email}'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Is Broadcaster approved?',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text('${_isAproved}'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Website: ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text('examplesite.com')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Summary',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vestibulum, felis at sagittis mattis, ipsum massa aliquam justo, vel pharetra leo est nec mi. Pellentesque et imperdiet sem, nec luctus turpis. Quisque a turpis pretium, auctor nisi sit amet, mollis lectus. Quisque ac purus ut dui porta pellentesque. Nulla mollis tempus mattis. Curabitur ac mauris sed nulla tincidunt dictum. Ut et massa in dolor tristique dignissim ut a turpis.'),
                  _isAproved
                      ? ElevatedButton(
                          onPressed: (() async {
                            setState(() {
                              _isAproved = false;
                            });

                            FirebaseFirestore.instance
                                .collection("Broadcasters")
                                .doc(widget.broadcaster.id)
                                .update(widget.broadcaster.toJson());
                          }),
                          child: Text('Revoke Approval'))
                      : ElevatedButton(
                          onPressed: (() async {
                            setState(() {
                              _isAproved = true;
                            });

                            FirebaseFirestore.instance
                                .collection("Broadcasters")
                                .doc(widget.broadcaster.id)
                                .update(widget.broadcaster.toJson());
                          }),
                          child: Text('Approve Broadcaster')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
