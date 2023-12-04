import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _step = 1;
  final TextEditingController _nameController = TextEditingController();
  int _age = 0;

  @override
  Widget build(BuildContext context) {
    final clrSchm = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              clrSchm.primary.withOpacity(0.4),
              clrSchm.secondary.withOpacity(0.4),
              clrSchm.inversePrimary.withOpacity(0.4),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              child: Image.asset('assets/images/andy_2.gif', height: 160),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'What do I call you?', hintText: 'Enter your unique name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: clrSchm.primaryContainer,width: 4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'How old might you be?', hintText: 'Enter your age',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.calendar_today),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: clrSchm.primaryContainer, width: 4)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 46, horizontal: 16),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            gotoStep(++_step);
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(clrSchm.primaryContainer),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 16)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
          child: const Text('Submit', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  void gotoStep(int i) {}
}