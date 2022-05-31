import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fun_olympics/spectator/model/video.dart';
import 'package:fun_olympics/spectator/pages/video_screen.dart';
import 'package:fun_olympics/spectator/utils/search.dart';

import '../widgets/video_cell.dart';

class Home extends StatefulWidget {
  static const route = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        leadingWidth: 200.0,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        leading: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'images/fo_logo.png',
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // TODO Implement search
                // showSearch(context: context, delegate: MySearch());
              }),
          IconButton(
              icon: const Icon(Icons.account_circle_outlined),
              onPressed: () {
                // TODO Create and navigate to user profile
                // to open user account
              }),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // TODO Add signout method
              // to log user out and return to auth page
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

// Widget for grid cells

// class VideoCell extends StatelessWidget {
//   final Video video;
//   const VideoCell(this.video);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         side: BorderSide(color: Colors.blueAccent, width: 2),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       color: Colors.white70,
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Container(
//           alignment: Alignment.center,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Flexible(
//                   child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Hero(
//                   tag: video.title.toString(),
//                   child: FadeInImage.assetNetwork(
//                     placeholder: "images/thumbnail.png",
//                     image: "images/thumbnail.png",
//                     width: 400,
//                     height: 400,
//                   ),
//                 ),
//               )),
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Text(
//                   video.title.toString(),
//                   maxLines: 2,
//                   softWrap: true,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
