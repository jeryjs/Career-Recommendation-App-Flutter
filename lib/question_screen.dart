// ignore_for_file: prefer_const_constructors, prefer_final_fields, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _step = 1;
  late int _totSteps = _qnTitles.length;
  List<String> _qnTitles = [
    "Your interests",
    "Your personality",
    'Your skills',
    'Your goals',
  ];
  List<List<String>> _opts = [
    [
      "Sports",
      "Music",
      "Art",
      "Dance",
      "Reading",
      "Coding",
      "Gardening",
      "Cooking",
      "Photography",
      "Traveling",
      "Writing",
      "Yoga",
      "Gaming",
      "Hiking",
      "Fishing",
      "Painting",
      "Singing",
      "Swimming",
      "Knitting",
      "Chess"
    ],
    [
      "Outgoing",
      "Friendly",
      "Creative",
      "Analytical",
      "Persistent",
      "Flexible",
      "Patient",
      "Responsible",
      "Independent",
      "Organized",
      "Detail-oriented",
      "Adventurous",
      "Calm",
      "Enthusiastic",
      "Ambitious",
      "Curious",
      "Empathetic",
      "Assertive",
      "Humorous",
      "Imaginative"
    ],
    [
      "Programming",
      "Designing",
      "Testing",
      "Debugging",
      "Problem Solving",
      "Communication",
      "Project Management",
      "Data Analysis",
      "Creativity",
      "Leadership",
      "Time Management",
      "Collaboration",
      "Adaptability",
      "Decision Making",
      "Critical Thinking",
      "Networking",
      "Negotiation",
      "Conflict Resolution",
      "Customer Service",
      "Technical Writing"
    ],
    [
      "Get fit",
      "Volunteer",
      "Buy a house",
      "Travel more",
      "Write a book",
      "Change careers",
      "Run a marathon",
      "Get a promotion",
      "Start a business",
      "Learn a new skill",
      "Improve creativity",
      "Save for retirement",
      "Learn a new language",
      "Improve communication",
      "Improve problem solving",
      "Improve time management",
      "Improve technical skills",
      "Improve work-life balance",
      "Improve leadership skills",
      "Spend more time with family and friends"
    ],
    [''],
  ];
  late List<bool> _selectedOpts;

  gotoStep(int i) {
    setState(() {
      _step = i;
      _selectedOpts =
          List<bool>.generate(_opts[_step - 1].length, (index) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedOpts =
        List<bool>.generate(_opts[_step - 1].length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      child: Column(
        children: [
          // Text('Step $_step out of $_totSteps'),
          LinearPercentIndicator(
            lineHeight: 18.0,
            percent: _step / _totSteps,
            center: Text('Step $_step out of $_totSteps', style: TextStyle(fontSize: 12.0)),
            trailing: Icon(Icons.mood, color: Theme.of(context).colorScheme.primary.withAlpha((_step/_totSteps*255).round())),
            barRadius: Radius.circular(50),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            progressColor: Theme.of(context).colorScheme.primaryContainer,
            curve: Curves.easeInCirc,
            animateFromLastPercent: true,
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
            ),
            child: Slider(
              value: _step / _totSteps,
              onChanged: (double value) {
                gotoStep(
                    ((value * _totSteps).toInt() > 0)
                    ? (value * _totSteps).toInt()
                    : 1
                  );
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_qnTitles[_step - 1], style: TextStyle(fontSize: 28)),
              Text('Pick what describe you best~',
                  style: Theme.of(context).textTheme.titleSmall),
              Padding(padding: EdgeInsets.only(top: 50)),
              Stack(clipBehavior: Clip.none, children: <Widget>[
                Card(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children:
                          List<Widget>.generate(_opts[_step - 1].length, (i) {
                        return FilterChip(
                          label: Text(_opts[_step - 1][i]),
                          selected: _selectedOpts[i],
                          onSelected: (s) =>
                              setState(() => _selectedOpts[i] = s),
                        );
                      }),
                    ),
                  ),
                ),
                Positioned(
                  top: -125,
                  right: -10,
                  child: Image.asset('assets/images/andy_2.gif', width: 80),
                ),
              ]),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 46, horizontal: 16),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      gotoStep(_step + 1);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primaryContainer,
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 16),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    child: Text('Submit', style: TextStyle(fontSize: 20))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
