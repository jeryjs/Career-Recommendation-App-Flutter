// ignore_for_file: prefer_const_constructors

import 'package:ashiq/question_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.greenAccent,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Course Rec!'),
          backgroundColor: Colors.transparent,
        ),
        body: QuestionScreen(),
      ),
    );
  }
}
