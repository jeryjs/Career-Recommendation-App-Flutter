import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ashiq/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final clrSchm = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: clrSchm.surface,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(175)),
            child: Image.asset('assets/images/building_an_app.png', height: 290, fit: BoxFit.cover),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: _nameController, maxLines: 1,
              decoration: InputDecoration(
                labelText: "What do I call you?", hintText: "Enter your unique name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: clrSchm.primaryContainer, width: 4),
                ),
              ),
              style: TextStyle(color: clrSchm.primary, fontSize: 15),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: _ageController, maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: "How old might you be?", hintText: "Enter your age",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                prefixIcon: const Icon(Icons.calendar_today),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: clrSchm.primaryContainer, width: 4),
                ),
              ),
              style: TextStyle(color: clrSchm.primary, fontSize: 15),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 46, horizontal: 16),
        width: double.infinity,
        child: loginButtonWD(context),
      ),
    );
  }

  Widget loginFormWD({required String title, required TextEditingController controller, bool digits = false}) {
    final clrSchm = Theme.of(context).colorScheme;
    return SizedBox(
      height: 58,
      child: TextField(
        controller: controller,
        maxLines: 1,
        keyboardType: digits ? TextInputType.number : null,
        inputFormatters: digits ? <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ] : null,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
          prefixIcon: const Icon(Icons.calendar_today),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: clrSchm.primaryContainer,
              width: 4,
            ),
          ),
        ),
        style: TextStyle(
          color: clrSchm.primary,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget loginButtonWD(BuildContext context) {
    final clrSchm = Theme.of(context).colorScheme;
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QuestionScreen()));
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: clrSchm.onPrimary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(99))),
        ),
        child: Text(
          'Proceed',
          style: TextStyle(
            color: clrSchm.onBackground,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
}
}

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clrSchm = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        title: const Text(
          'Appearance',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<AdaptiveThemeMode?>(
              valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
              builder: (_, mode, child) {
                return Text(
                  'App Theme',
                  style: TextStyle(
                    color: mode?.isLight ?? true ? clrSchm.onBackground : clrSchm.background,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<AdaptiveThemeMode?>(
              valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
              builder: (_, mode, child) {
                return GestureDetector(
                  onTap: () {
                    AdaptiveTheme.of(context).setLight();
                  },
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      color: clrSchm.primaryContainer,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                        color: mode?.isLight ?? false ? clrSchm.primary : clrSchm.primaryContainer,
                        width: 7,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<AdaptiveThemeMode?>(
              valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
              builder: (_, mode, child) {
                return GestureDetector(
                  onTap: () {
                    AdaptiveTheme.of(context).setDark();
                  },
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      color: clrSchm.primaryContainer,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                        color: mode?.isDark ?? false ? clrSchm.primary : clrSchm.primaryContainer,
                        width: 7,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}