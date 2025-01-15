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
}
