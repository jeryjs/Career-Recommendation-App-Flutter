import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ashiq/question_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    final clrSchm = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: clrSchm.surface,
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            height: _isAnimating ? MediaQuery.of(context).size.height*0.75 : 290,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(175)),
              child: Image.asset('assets/images/building_an_app.png', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 46, horizontal: 16),
        width: double.infinity,
        child: preoceedButton(context),
      ),
    );
  }

  Widget preoceedButton(BuildContext context) {
    final clrSchm = Theme.of(context).colorScheme;
    return SizedBox(
      height: 58,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isAnimating = true;
          });
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(seconds: 1),
                pageBuilder: (context, animation, secondaryAnimation) => const QuestionScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          });
        },
        // color: clrSchm.primary,
        child: const Text('Proceed'),
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