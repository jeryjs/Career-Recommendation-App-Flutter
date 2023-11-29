// ignore_for_file: prefer_const_constructors, prefer_final_fields, deprecated_member_use
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'question_data.dart';

// Define a StatefulWidget as it maintains state that can change over time
class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // Initialize variables
  int _index = 0, _step = 1;
  late int _totSteps;
  late QuestionData qns, ans;

  // Function to load JSON data
  Future<QuestionData> loadJsonData(String path) async {
    String jsonString = await rootBundle.loadString(path);
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return QuestionData.fromJson(jsonData);
  }

  // Function to navigate to a specific step
  void gotoStep(int i) {
    setState(() {
      i <= 0 ? i = 1 : i;
      i > _totSteps ? i = _totSteps : i;
      _step = i;
      _index = i - 1;
      ans.titles[_index] = qns.titles[_index];
      ans.options[_index].map((e) => null);
    });
  }

  // Initialize state
  @override
  void initState() {
    super.initState();
    loadJsonData('assets/data/questions.json').then((data) {
      setState(() {
        qns = data;
        _totSteps = qns.titles.length;
        ans = QuestionData(
            titles: List.from(qns.titles),
            options: qns.options.map((o) => o.map((e) => '').toList()).toList()
          );
        ans.options[_index].map((e) => '');
      });
    });
  }

  // Build the UI
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(2),
        child: Column(
          children: [
            // Progress indicator
            LinearPercentIndicator(
              lineHeight: 18.0,
              percent: _step / _totSteps,
              center: Text('Step $_step out of $_totSteps', style: TextStyle(fontSize: 12.0)),
              leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => gotoStep(--_step)),
              trailing: IconButton(icon: Icon(Icons.arrow_forward), onPressed: () => gotoStep(++_step)),
              barRadius: Radius.circular(50),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              progressColor: Theme.of(context).colorScheme.primaryContainer,
              curve: Curves.easeInCirc,
              animateFromLastPercent: true,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: min(560, screenSize.width * 0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(qns.titles[_index], style: TextStyle(fontSize: 26)),
                          Text('Pick what describe you best~', style: TextStyle(fontSize: 14)),
                        ],
                      )),
                      Image.asset('assets/images/andy_2.gif', width: 70)
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40)),

                // Card for displaying options
                Card(
                  child: Container(
                    alignment: Alignment.center,
                    width: min(560, screenSize.width * 0.9),
                    height: screenSize.height * 0.45,
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: screenSize.width < 560 ? 8.0 : 26.0,
                      runSpacing: screenSize.width < 560 ? 8.0 : 26.0,
                      children: List<Widget>.generate(qns.options[_index].length, (i) {
                        return FilterChip(
                          label: Text(qns.options[_index][i]),
                          selected: ans.options[_index][i] == '' ? false : true,
                          onSelected: (s) {
                            setState(() {
                              ans.options[_index][i] = ans.options[_index][i] == '' ? qns.options[_index][i] : '';
                            });
                          },
                        );
                      }),
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Submit button
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 46, horizontal: 16),
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              if (_step == _totSteps) {
                debugPrint('Submit: ${ans.toJson()}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Here's what the json to send to gpt would look like:\n\n${ans.toJson()}"),
                    duration: Duration(seconds: 5),
                  ),
                );
              }
              gotoStep(++_step);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primaryContainer),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 16)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            ),
            child: Text('Submit', style: TextStyle(fontSize: 20))),
      ),
    );
  }
}