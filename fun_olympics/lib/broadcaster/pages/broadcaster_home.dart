import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/broadcaster/pages/broadcaster_login.dart';
import 'package:fun_olympics/broadcaster/pages/upload_port.dart';
import 'package:fun_olympics/broadcaster/pages/upload_video.dart';
import 'package:fun_olympics/broadcaster/utils/authentication_broadcaster.dart';

import '../../spectator/model/video.dart';
import '../../spectator/pages/video_screen.dart';

class BroadcasterHome extends StatefulWidget {
  static const route = '/broadcaster-home';
  const BroadcasterHome({Key? key}) : super(key: key);

  @override
  State<BroadcasterHome> createState() => _BroadcasterHomeState();
}

class _BroadcasterHomeState extends State<BroadcasterHome> {
  final _auth = AuthBroadcaster();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(
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
            icon: const Icon(Icons.account_box),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const UploadPortfolio()));
            },
          ),
          IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const UploadPage()));
              }),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOutBroadcaster();
              // Navigator.of(context).pushNamed(SpectatorLogin.route);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  BroadcasterLogin.route, (route) => false);
            },
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Video>>(
          stream: getVideos(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final videos = snapshot.data!;

              return ListView(
                children: videos.map(buildVids).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  // build the grid with videos
  Widget buildVids(Video vid) => ListTile(
        leading: const Icon(Icons.play_arrow),
        title: Text(vid.title.toString()),
        subtitle: Text(vid.id.toString()),
        onTap: () => vidItem(context, vid),
      );

  //get videos from firestore
  Stream<List<Video>> getVideos() => FirebaseFirestore.instance
      .collection('videos')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Video.fromJson(doc.data())).toList());

  //when cell is clicked
  void vidItem(BuildContext context, Video video) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => VideoScreen(video: video)));
  }
}
