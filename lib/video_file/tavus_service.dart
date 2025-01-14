import 'dart:convert';
import 'package:http/http.dart' as http;

class TavusService {
  final String apiKey = "70e8feaa5c63469fa2c3eb3b90f267e1"; // Replace with your actual API key
  final String baseUrl = "https://tavusapi.com/v2";

  /// Create a new video
  Future<String> createVideo({
    required String backgroundUrl,
    required String replicaId,
    required String script,
    required String videoName,
  }) async {
    final url = Uri.parse('$baseUrl/videos');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
        },
        body: jsonEncode({
          "background_url": backgroundUrl,
          "replica_id": replicaId,
          "script": script,
          "video_name": videoName,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("Video created successfully: ${data['video_id']}");
        return data['video_id']; // Returns the ID of the created video
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
        return "Error: ${response.statusCode}, ${response.body}";
      }
    } catch (e) {
      print("Failed to create video: $e");
      return "Failed to create video: $e";
    }
  }

  /// Fetch video details by ID
  Future<Map<String, dynamic>> fetchVideoDetails(String videoId) async {
    final url = Uri.parse('$baseUrl/videos/$videoId');
    try {
      final response = await http.get(
        url,
        headers: {
          'x-api-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Video details: $data");
        return data;
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
        return {"error": "Error: ${response.statusCode}, ${response.body}"};
      }
    } catch (e) {
      print("Failed to fetch video details: $e");
      return {"error": "Failed to fetch video details: $e"};
    }
  }
}
