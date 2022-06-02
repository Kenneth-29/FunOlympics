import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_olympics/spectator/model/comment_model.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../model/video.dart';

class VideoScreen extends StatefulWidget {
  final Video video;
  // ignore: use_key_in_widget_constructors
  const VideoScreen({required this.video});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _ctrl;
  final cmt = TextEditingController();
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
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: YoutubePlayerIFrame(
              controller: _ctrl,
              aspectRatio: 16 / 9,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Container(
                // color: Colors.blue,
                alignment: Alignment.center,
                child: StreamBuilder<List<Comment>>(
                  stream: getComments(),
                  builder: (context, snapshots) {
                    if (snapshots.hasError) {
                      return Text('Something went wrong! ${snapshots.error}');
                    } else if (snapshots.hasData) {
                      final comments = snapshots.data!;

                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 50, right: 50),
                        child: ListView(
                            children: comments.map(buildComments).toList()),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
          ),

          SizedBox(
            height: 20,
          ),
          // ignore: prefer_const_constructors
          Card(
            // ignore: prefer_const_constructors
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ViewComment()));
                    },
                    child: Text('View Comments')),
                TextField(
                  controller: cmt,
                  decoration: const InputDecoration(
                    hintText: 'Enter your comment here',
                    // suffix: IconButton(
                    //     onPressed:  , icon: Icon(Icons.send)),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      Comment nComment = Comment(
                        id: widget.video.id,
                        username: 'Kenneth',
                        comment: cmt.text,
                      );
                      FirebaseFirestore.instance
                          .collection('comments')
                          .doc(nComment.id)
                          .set(nComment.toJson());
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }

  _addComment() async {
    Comment nComment = Comment(
      id: widget.video.id,
      username: 'Kenneth',
      comment: cmt.text,
    );
    try {
      await FirebaseFirestore.instance
          .collection('comments')
          .doc(nComment.id)
          .set(nComment.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  Stream<List<Comment>> getComments() => FirebaseFirestore.instance
      .collection('comments')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList());

  Widget buildComments(Comment comment) => ListTile(
        shape: const Border(
          bottom: BorderSide(color: Colors.blueAccent),
        ),
        leading: const Icon(Icons.account_circle),
        title: Text(
          comment.username.toString(),
          style: TextStyle(color: Colors.black45),
        ),
        subtitle: Text(comment.comment.toString()),
      );
  @override
  void initState() {
    super.initState();
    _ctrl = YoutubePlayerController(
      initialVideoId: widget.video.id.toString(),
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        autoPlay: true,
      ),
    );

    _ctrl.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _ctrl.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }
}

class ViewComment extends StatefulWidget {
  ViewComment({Key? key}) : super(key: key);

  @override
  State<ViewComment> createState() => _ViewCommentState();
}

class _ViewCommentState extends State<ViewComment> {
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
        // ignore: prefer_const_constructors
      ),
      body: StreamBuilder<List<Comment>>(
        stream: getComments(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return Text('Something went wrong! ${snapshots.error}');
          } else if (snapshots.hasData) {
            final comments = snapshots.data!;

            return Padding(
              padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
              child: ListView(children: comments.map(buildComments).toList()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
  // _addComment() async {
  //   Comment nComment = Comment(
  //     id: widget.video.id,
  //     username: 'Kenneth',
  //     comment: cmt.text,
  //   );
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('comments')
  //         .doc(nComment.id)
  //         .set(nComment.toJson());
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  Stream<List<Comment>> getComments() => FirebaseFirestore.instance
      .collection('comments')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList());

  Widget buildComments(Comment comment) => ListTile(
        shape: const Border(
          bottom: BorderSide(color: Colors.blueAccent),
        ),
        leading: const Icon(Icons.account_circle),
        title: Text(
          comment.username.toString(),
          style: TextStyle(color: Colors.black45),
        ),
        subtitle: Text(comment.comment.toString()),
      );
}
