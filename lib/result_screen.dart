// ignore_for_file: unnecessary_string_escapes, prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'question_data.dart';
import 'chat_screen.dart';

class ResultScreen extends StatefulWidget {
  final QuestionData answers;

  const ResultScreen({super.key, required this.answers});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with TickerProviderStateMixin {
  late Future<ResultData> futureResult;
  late String systemString, userString;
  List<String> loadingPhrases = [
    'Working on it, one sec.', 'I\'ll get back to you on that.', 'Just a moment, please.',
    'Let me check on that.', 'I\'m almost there.', 'Hang tight.', 'Coming right up.',
    'I\'m on it.', 'Be right back.', 'Just a sec, I\'m buffering.'
  ];

  @override
  void initState() {
    super.initState();

    systemString = """
      You are a super thoughtful course recommender for grade 10-12 students.
      You read data given to you in json format and ONLY reply in json format.
      You recommend 5 courses based on input json and provide a very enthusiastic and short reasoning for each course in 5-10 words.
      The output should be in this exact same format:
      {\"course1name\": \"reasoning1\", \"course2name\": \"reasoning2\",....}
      Here's an example output format for u to use to base ur reply on-
      {\"Flutter Programmer\": \"I bet there\"s no better place to improve your programming skills!!\", \"Design Architect\": \"Let your imagination flow into the world around you!!\",....}
    """;
    userString = """
      HERE IS THE USER'S ANSWERS:
      ${widget.answers.toJson()}
    """;

    // futureResult = fetchResultFromGPT();
    futureResult = fetchResultFromBard();
  }

  Future<ResultData> fetchResultFromGPT() async {
    OpenAI.apiKey = await rootBundle.loadString('assets/openai.key');
    OpenAI.showLogs = true;
    OpenAI.showResponsesLogs = true;

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.system,
      content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(systemString)],
    );
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(userString)],
    );

    final completion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      messages: [systemMessage, userMessage],
      maxTokens: 500,
      temperature: 0.2,
    );

    if (completion.choices.isNotEmpty) {
      return ResultData.fromJson(completion.choices.first.message.content!.first.text.toString());
    } else {
      throw Exception('Failed to load result');
    }
  }

  Future<ResultData> fetchResultFromBard() async {
    final apiKey = await rootBundle.loadString('assets/bard.key');
    final endpoint = "https://generativelanguage.googleapis.com/v1beta3/models/text-bison-001:generateText?key=$apiKey";
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'prompt': {
          'text': '$systemString\n\n$userString',
        },
      }),
    );

    if (response.statusCode == 200) {
      String result = jsonDecode(response.body)['candidates'][0]['output'];
      debugPrint('Result: $result');
      return ResultData.fromJson(result);
    } else {
      throw Exception('Failed to load result: ${response.body}');
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  [
                    SpinKitPouringHourGlassRefined(color: clrSchm.primary, size: 120),
                    SpinKitDancingSquare(color: clrSchm.primary, size: 120),
                    SpinKitSpinningLines(color: clrSchm.primary, size: 120),
                    SpinKitPulsingGrid(color: clrSchm.primary, size: 120)
                  ][Random().nextInt(4)],
                  const SizedBox(height: 10),
                  StreamBuilder<String>(
                    stream: Stream.periodic(const Duration(seconds: 3), (i) => loadingPhrases[Random().nextInt(loadingPhrases.length)]),
                    builder: (context, snapshot) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SizeTransition(sizeFactor: animation, axis: Axis.horizontal, axisAlignment: -1, child: child),
                          );
                        },
                        child: Text(
                          snapshot.data ?? loadingPhrases[Random().nextInt(loadingPhrases.length)],
                          key: ValueKey<String>(snapshot.data ?? loadingPhrases[Random().nextInt(loadingPhrases.length)]),
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
              itemCount: snapshot.data?.result.length,
              itemBuilder: (context, index) {
                final entry = snapshot.data?.result.entries.elementAt(index);
                return FutureBuilder(
                  future: Future.delayed(Duration(milliseconds: 200 * index)),
                  builder: (context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(); // Empty container
                    } else {
                      return SlideTransition(
                        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
                          CurvedAnimation(
                            parent: AnimationController(duration: const Duration(milliseconds: 300), vsync: this)..forward(),
                            curve: Curves.easeInOutSine,
                          ),
                        ),
                        child: Padding(
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(course: entry!.key, ans: widget.answers)));
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                                  title: Text(entry!.key, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  subtitle: Text(entry.value, style: TextStyle(fontSize: 16,)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
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
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    Map<String, String> resultMap = {};

    jsonMap.forEach((key, value) {
      resultMap[key] = value.toString();
    });

    debugPrint('ResultMap: $resultMap');

    return ResultData(result: resultMap);
  }
}
