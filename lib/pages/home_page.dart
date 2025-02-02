import 'package:flutter/material.dart';
import 'package:untitled1/api_file/api.dart';
import 'package:untitled1/pages/video.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final GeminiService _geminiService = GeminiService();
  String answer2="";
  String _response = "";

  void _askQuestion() async {
    final question = _controller.text.trim();
    if (question.isNotEmpty) {
      final answer = await _geminiService.getAnswer(question);
      answer2 = await _geminiService.getAnswer(
          "give a prompt for this question and answer to generate an animated ai video that relate with real lie \nQuestion:-$question\nAnswer:-$answer");
      setState(() {
        _response = answer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question ChatBot"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: "Ask a question",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _askQuestion,
                  child: Text("Get Answer"),
                ),
                SizedBox(height: 16),
                Text(
                  _response,
                  style: TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VideoMaker(script: answer2)));
                    },
                    child: Text("Get Video")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
