// ignore_for_file: unnecessary_string_escapes, prefer_const_constructors

import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';

import 'question_data.dart';

class ResultScreen extends StatefulWidget {
  final QuestionData answers;

  const ResultScreen({super.key, required this.answers});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Future<ResultData> futureResult;

  @override
  void initState() {
    super.initState();
    futureResult = fetchResult();
  }

  Future<ResultData> fetchResult() async {
    OpenAI.apiKey = Platform.environment['OPENAI_API_KEY']!;
    OpenAI.showLogs = true;
    OpenAI.showResponsesLogs = true;

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.system,
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text("""
                You are a super thoughtful course recommender for grade 10-12 students.
                You read data given to you in json format and ONLY reply in json format.
                You recommend 5 courses based on input json and provide a very enthusiastic and short reasoning for each course in 5-10 words.
                The output should be in this format:
                [\"course1name\": \"reasoning1\", \"course2name\": \"reasoning2\",....]
                Here\"s an example output format for u to use to base ur reply on-
                [\"Flutter Programmer\": \"I bet there\"s no better place to improve your programming skills!!\", \"Design Architect\": \"Let your imagination flow into the world around you!!\",....]
              """)
        ],
      );

    final userMessage = OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text("""
              HERE IS THE USER'S ANSWERS:
              ${widget.answers.toJson()}
            """)
        ],
      );

    final completion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      messages: [
        systemMessage,
        userMessage,
      ],
      maxTokens: 500,
      temperature: 0.2,
    );

    if (completion.choices.isNotEmpty) {
      return ResultData.fromJson(
          completion.choices.first.message.content!.first.text.toString());
    } else {
      throw Exception('Failed to load result');
    }
  }

  @override
  Widget build(BuildContext context) {
    final clrSchm = Theme.of(context).colorScheme; // color scheme

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Screen'),
      ),
      body: Center(
        child: FutureBuilder<ResultData>(
          future: futureResult,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LinearProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.result.length,
                itemBuilder: (context, index) {
                  final entry = snapshot.data?.result.entries.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [clrSchm.inversePrimary, clrSchm.secondaryContainer],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          title: Text(entry!.key, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Text(entry.value, style: TextStyle(fontSize: 16,)),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class ResultData {
  final Map<String, String> result;

  ResultData({required this.result});

  factory ResultData.fromJson(String jsonString) {
    jsonString = jsonString.substring(1, jsonString.length - 1); // Remove the outer brackets
    List<String> entries = jsonString.split('", "'); // Split the string into entries
    Map<String, String> resultMap = {};

    for (var entry in entries) {
      List<String> parts = entry.split(': '); // Split the entry into key and value
      String key = parts[0].replaceAll('"', ''); // Remove the quotes around the key
      String value = parts[1].replaceAll('"', ''); // Remove the quotes around the value
      resultMap[key] = value;
    }

    debugPrint('ResultMap: $resultMap');

    return ResultData(result: resultMap);
  }
}
