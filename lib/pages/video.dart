import 'package:flutter/material.dart';
import 'package:untitled1/api_file/video_service.dart';

class VideoMaker extends StatefulWidget {
  const VideoMaker({
    required this.script,
    super.key
  });
  final String script;
  @override
  VideoMakerState createState() => VideoMakerState();
}

class VideoMakerState extends State<VideoMaker> {
  final VideoService _tavusService = VideoService();
  Map<String, dynamic> videoDetails ={};
  String videoId="";

  void _createVideo() async {
    videoId = await _tavusService.createVideo(
      backgroundUrl: "",
      replicaId: "r4c41453d2",
      script: widget.script,
      videoName: "Test Video",
    );
    _fetchVideoDetails(videoId);
    if (!videoId.contains("Error")) {
      print("Video Created with ID: $videoId");
    } else {
      print("Error Creating Video: $videoId");
    }
  }

  void _fetchVideoDetails(String videoId) async {
    videoDetails = await _tavusService.fetchVideoDetails(videoId);

    if (videoDetails.containsKey("error")) {
      print("Error: ${videoDetails['error']}");
    } else {
      print(videoDetails["stream_url"]);
      print("Video Details: $videoDetails");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creating Video"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _createVideo,
              child: Text("Create Video"),
            ),
            Text(videoDetails["stream_url"]??"Stream not available"),
          ],
        ),
      ),
    );
  }
}
