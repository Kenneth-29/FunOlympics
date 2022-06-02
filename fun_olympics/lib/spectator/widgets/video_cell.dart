import 'package:flutter/material.dart';

import '../model/video.dart';

class VideoCell extends StatelessWidget {
  final Video video;
  // ignore: use_key_in_widget_constructors
  const VideoCell(this.video);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: video.title.toString(),
                  child: FadeInImage.assetNetwork(
                    placeholder: "images/thumbnail.png",
                    image: "images/thumbnail.png",
                    width: 400,
                    height: 400,
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  video.title.toString(),
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
