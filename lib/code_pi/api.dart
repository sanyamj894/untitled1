import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey = "AIzaSyAUMkptXc14jmmVpFBcliUpLbFeU9nCIlk"; // Replace with your actual API key
  final String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent"; // Correct endpoint

  final String videoApiKey = "70e8feaa5c63469fa2c3eb3b90f267e1"; // Replace with your actual API key
  final String videoApiUrl = "https://tavusapi.com/v2/replicas";

  Future<String> getAnswer(String question) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": question}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data); // Print the full response for debugging
        return data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        print("Error: ${response.statusCode}, Body: ${response.body}");
        return "Error: ${response.statusCode}, ${response.body}";
      }
    } catch (e) {
      print("Failed to get a response: ${e.toString()}");
      return "Failed to get a response: $e";
    }
  }

  Future<String> createReplica() async {
    String callbackUrl="https://tavus-callback.onrender.com/tavus-callback";///////replace
    String replicaName="";////////replace
    String trainVideoUrl="https://github.com/sanyamj894/tavus-callback/blob/master/video/CAT%20Exam%20Preparation%20_%20Geometry%20Concepts%20Explained.mp4";////////////////replace
    try {
      final response = await http.post(
        Uri.parse(videoApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': videoApiKey,
        },
        body: jsonEncode({
          "callback_url": callbackUrl,
          "replica_name": replicaName,
          "train_video_url": trainVideoUrl,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("Success: ${data.toString()}");
        return "Replica created successfully: ${data['replica_id']}";
      } else {
        print("Error: ${response.statusCode}, Body: ${response.body}");
        return "Error: ${response.statusCode}, ${response.body}";
      }
    } catch (e) {
      print("Failed to create replica: $e");
      return "Failed to create replica: $e";
    }
  }
}
