import 'package:flutter/material.dart';
import 'tavus_service.dart';

class TavusExample extends StatefulWidget {
  const TavusExample({
    required this.script,
    super.key
  });
  final String script;
  @override
  _TavusExampleState createState() => _TavusExampleState();
}

class _TavusExampleState extends State<TavusExample> {
  final TavusService _tavusService = TavusService();
  Map<String, dynamic> videoDetails ={};
  String videoId="";

  void _createVideo() async {
    videoId = await _tavusService.createVideo(
      backgroundUrl: "",
      replicaId: "r4c41453d2",
      script: widget.script,
      videoName: "Test Video",
    );

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
      print("Video Details: $videoDetails");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tavus API Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _createVideo,
              child: Text("Create Video"),
            ),
            ElevatedButton(
              onPressed: () {
                _fetchVideoDetails(videoId);
              },
              child: Text("Fetch Video Details"),
            ),
            Text(videoDetails["stream_url"]??"Stream not available"),
          ],
        ),
      ),
    );
  }
}
