// Remove the 'dart:convert' import statement
//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:dart_openai/dart_openai.dart';

class ChatScreen extends StatefulWidget {
  final String course;

  const ChatScreen({super.key, required this.course});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin:
          EdgeInsets.symmetric(vertical: 4.0, horizontal: isUser ? 40.0 : 8.0),
      decoration: BoxDecoration(
        color: isUser ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        message,
        style: TextStyle(color: isUser ? Colors.white : Colors.black),
      ),
    );
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  // ignore: unused_field
  late Future<String> _futureResult;
  final List<ChatBubble> _chatHistory = []; // Make it a List<ChatBubble>

  @override
  void initState() {
    super.initState();
    _futureResult = fetchResultFromGPT(context, widget.course);
  }

  Future<String> fetchResultFromGPT(BuildContext context, String course) async {
    OpenAI.apiKey = await rootBundle.loadString('assets/openai.key');
    OpenAI.showLogs = true;
    OpenAI.showResponsesLogs = true;

    final prompt =
        "Hello! I'm interested in learning more about $course. Can you tell me more about the course and provide some suggestions on what I should learn first?";

    final completion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.user,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)
          ],
        ),
      ],
      maxTokens: 150,
      temperature: 0.7,
    );

    if (completion.choices.isNotEmpty) {
      return completion.choices.first.message.content!.first.text.toString();
    } else {
      throw Exception('Failed to load result');
    }
  }

  void _submitMessage() async {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      _textController.clear();
      // Wait for the result before updating the chat history
      final result = await fetchResultFromGPT(context, widget.course);
      setState(() {
        _chatHistory.add(ChatBubble(message: 'You: $text', isUser: true));
        _chatHistory.add(ChatBubble(message: 'Bot: $result', isUser: false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen: ${widget.course}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _chatHistory.length,
                itemBuilder: (context, index) {
                  final chatBubble = _chatHistory[index];
                  return index % 2 == 0
                      ? Text(chatBubble.message)
                      : Text(
                          chatBubble.message,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        );
                },
              ),
            ),
            const Divider(height: 1.0),
            ListTile(
              title: TextField(
                controller: _textController,
                onSubmitted: (value) => _submitMessage(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type your message...',
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _submitMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
