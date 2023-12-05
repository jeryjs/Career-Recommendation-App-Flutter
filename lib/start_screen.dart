// Import statements for Flutter packages or other dependencies if needed

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class DesignSystem {
  const DesignSystem._();

  static const fontFamily = 'NotoSans';

  /// Body
  ///
  static const double bodyText1Size = 18;
  static const double bodyText2Size = 16;
  static const double bodyText3Size = 15;
  static const double bodyText4Size = 14;
  static const double bodyText5Size = 13;
  static const double bodyText6Size = 12;
  static const double bodyText7Size = 11;
  static const double bodyText8Size = 10;

  /// Colors
  ///
  static const g0 = Color(0xff000000);
  static const g1 = Color(0xffFFFFFF);
  static const g2 = Color(0xff01042a);
  static const g3 = Color(0xff47496d);
  static const g4 = Color(0xff1b1a1e);
  static const g5 = Color(0xffabc5ff);
  static const g6 = Color(0xffe3e2e7);
  static const g7 = Color(0xffbbbabe);

  static const disable = Color(0xffAAAAAA);
  static const error = Colors.red;
  static const success = Colors.green;
  static const primary = Color(0xff171a92);
}

class CRATheme {
  CRATheme._();

  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      fontFamily: DesignSystem.fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: DesignSystem.primary,
        centerTitle: false,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      fontFamily: DesignSystem.fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: DesignSystem.g4,
        centerTitle: false,
      ),
      scaffoldBackgroundColor: DesignSystem.g4,
    );
  }
}

class LoginAssets {
  LoginAssets._();

  static Widget get loginTitleImage => Image.asset(
        'assets/images/building_an_app.png',
        height: 290,
        fit: BoxFit.cover,
      );
}

class LoginButtonWD extends StatelessWidget {
  const LoginButtonWD({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ThemeSelectionPage()));
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: DesignSystem.primary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(99))),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            color: DesignSystem.g1,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordSectionWD extends StatelessWidget {
  const ForgetPasswordSectionWD({super.key});

  @override
  Widget build(BuildContext context) {
    // Add your ForgetPasswordSectionWD code here
    return Container(); // Placeholder, replace with actual code
  }
}

class RegisterSectionWD extends StatelessWidget {
  const RegisterSectionWD({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
            child: RichText(
              text: const TextSpan(
                text: "I don't have an account? ",
                style: TextStyle(
                  color: DesignSystem.g1,
                  fontSize: DesignSystem.bodyText4Size,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(
                      color: DesignSystem.success,
                      fontSize: DesignSystem.bodyText4Size,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoginFormWD extends StatelessWidget {
  const LoginFormWD({
    required this.title,
    this.obscureText = false,
    super.key,
  });

  final String title;
  final bool obscureText;

  InputBorder _getEnabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(99),
      borderSide: const BorderSide(
        width: 1.4,
        color: DesignSystem.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: TextField(
        maxLines: 1,
        onTapOutside: (e) => FocusScope.of(context).requestFocus(FocusNode()),
        enabled: true,
        style: const TextStyle(
          color: DesignSystem.g1,
          fontSize: DesignSystem.bodyText3Size,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(
            color: DesignSystem.g3,
            fontSize: DesignSystem.bodyText3Size,
          ),
          border: _getEnabledBorder(),
          enabledBorder: _getEnabledBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 23,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}

class LoginTitleWD extends StatelessWidget {
  const LoginTitleWD({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Login',
      style: TextStyle(
        color: DesignSystem.g1,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class ThemeCardWD extends StatelessWidget {
  const ThemeCardWD({
    required this.isSelected,
    required this.onPressed,
    required this.backgroundColor,
    required this.label,
    super.key,
  });

  final bool isSelected;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: isSelected ? DesignSystem.g5 : DesignSystem.g3,
                width: 7,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: DesignSystem.bodyText3Size,
          ),
        ),
      ],
    );
  }
}

class AppThemeTitleWD extends StatelessWidget {
  const AppThemeTitleWD({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdaptiveThemeMode?>(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (_, mode, child) {
        return Text(
          'App Theme',
          style: TextStyle(
            color: mode?.isLight ?? true ? DesignSystem.g2 : DesignSystem.g6,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        );
      },
    );
  }
}

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppThemeTitleWD(),
            SizedBox(height: 20),
            LightThemeCardWD(),
            SizedBox(height: 20),
            DarkThemeCardWD(),
          ],
        ),
      ),
    );
  }
}

class LightThemeCardWD extends StatelessWidget {
  const LightThemeCardWD({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdaptiveThemeMode?>(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (_, mode, child) {
        return ThemeCardWD(
          backgroundColor: DesignSystem.g1,
          label: 'Light',
          isSelected: mode?.isLight ?? false, // Use null-aware operator
          onPressed: () {
            AdaptiveTheme.of(context).setLight();
          },
        );
      },
    );
  }
}

class DarkThemeCardWD extends StatelessWidget {
  const DarkThemeCardWD({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdaptiveThemeMode?>(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (_, mode, child) {
        return ThemeCardWD(
          backgroundColor: DesignSystem.g4,
          label: 'Dark',
          isSelected: mode?.isDark ?? false, // Use null-aware operator
          onPressed: () {
            AdaptiveTheme.of(context).setDark();
          },
        );
      },
    );
  }
}

class DarkModeStatusWD extends StatelessWidget {
  const DarkModeStatusWD({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdaptiveThemeMode?>(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (_, mode, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _TitleWD(
                isLightMode: mode?.isLight ?? true), // Use null-aware operator
            const SizedBox(height: 8),
            _StatusTextWD(
                isLightMode: mode?.isLight ?? true), // Use null-aware operator
          ],
        );
      },
    );
  }
}

class _TitleWD extends StatelessWidget {
  const _TitleWD({required this.isLightMode});

  final bool isLightMode;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Dark mode',
      style: TextStyle(
        color: isLightMode ? DesignSystem.g2 : DesignSystem.g6,
        fontSize: 19,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _StatusTextWD extends StatelessWidget {
  const _StatusTextWD({required this.isLightMode});

  final bool isLightMode;

  @override
  Widget build(BuildContext context) {
    return Text(
      isLightMode ? 'Off' : 'On',
      style: TextStyle(
        color: isLightMode ? DesignSystem.g2 : DesignSystem.g6,
        fontSize: DesignSystem.bodyText4Size,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class ThemeTextWD extends StatelessWidget {
  const ThemeTextWD({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdaptiveThemeMode?>(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (_, mode, child) {
        final isLightMode =
            mode?.isLight ?? true; // Default to true if mode is null

        return Text(
          'Theme',
          style: TextStyle(
            color: isLightMode ? DesignSystem.g2 : DesignSystem.g5,
            fontSize: DesignSystem.bodyText2Size,
          ),
        );
      },
    );
  }
}
