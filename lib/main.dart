import 'package:flutter/material.dart';
import 'theme/gemify_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const GemifyApp());
}

class GemifyApp extends StatelessWidget {
  const GemifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gemify",
      theme: ThemeData(
        scaffoldBackgroundColor: GemifyTheme.background,
        primaryColor: GemifyTheme.sapphireBlue,
        colorScheme: ColorScheme.light(
          primary: GemifyTheme.sapphireBlue,
          secondary: GemifyTheme.emeraldGreen,
          background: GemifyTheme.background,
          surface: GemifyTheme.white,
          error: GemifyTheme.rubyRed,
        ),
        textTheme: GemifyTheme.textTheme,
      ),
      debugShowCheckedModeBanner: false,
      // Choose one of the following:
      home: const WelcomeScreen(), // ✅ Show welcome/onboarding/login first
      // OR
      // home: const BottomNavBar(), // ✅ Skip welcome and go directly to main app
    );
  }
}
