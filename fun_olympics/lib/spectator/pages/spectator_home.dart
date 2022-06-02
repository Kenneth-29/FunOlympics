import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/spectator/model/video.dart';
import 'package:fun_olympics/spectator/pages/spectator_login.dart';
import 'package:fun_olympics/spectator/pages/spectator_profile.dart';
import 'package:fun_olympics/spectator/pages/video_screen.dart';
import 'package:fun_olympics/spectator/utils/authentication.dart';

import '../widgets/video_cell.dart';

class Home extends StatefulWidget {
  static const route = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = AuthUser();
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
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const SearchPage()));
              }),
          IconButton(
              icon: const Icon(Icons.account_circle_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Profile()));
              }),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              // Navigator.of(context).pushNamed(SpectatorLogin.route);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  SpectatorLogin.route, (route) => false);
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

              return Padding(
                padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 600,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  children: videos.map(buildVids).toList(),
                ),
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
  Widget buildVids(Video vid) => GestureDetector(
        child: GridTile(
          child: VideoCell(vid),
        ),
        onTap: () {
          vidItem(context, vid);
        },
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

// search widget

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String search = "";
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
            Column(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close)),
                const Text(
                  'close',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                )
              ],
            ),
          ],
          backgroundColor: Colors.white,
          // ignore: prefer_const_constructors
          title: Card(
            // ignore: prefer_const_constructors
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search Video...'),
              onChanged: (val) {
                setState(() {
                  search = val;
                });
              },
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('videos').snapshots(),
            builder: (context, snapshots) {
              return (snapshots.connectionState == ConnectionState.waiting)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;

                        if (search.isEmpty) {
                          return ListTile(
                            title: Text(
                              data['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data['url'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(Icons.play_arrow),
                            iconColor: Colors.blueAccent,
                          );
                        }
                        if (data['title']
                            .toString()
                            .toLowerCase()
                            .startsWith(search.toLowerCase())) {
                          return ListTile(
                            title: Text(
                              data['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data['url'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(Icons.play_arrow),
                            iconColor: Colors.blueAccent,
                          );
                        }
                        return Container();
                      });
            }));
  }
}
