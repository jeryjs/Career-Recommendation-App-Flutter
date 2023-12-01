import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isLoading = false;

  void _handleSubmit() {
    // Perform any necessary operations before showing the loading state

    setState(() {
      isLoading = true;
    });

    // Simulate an asynchronous operation
    Future.delayed(Duration(seconds: 3), () {
      // Perform any necessary operations after the loading state is complete

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Submit'),
            ),
            Visibility(
              visible: isLoading,
              child: LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
