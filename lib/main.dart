import 'package:flutter/material.dart';

import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/diary/add_diary_entry_screen.dart';
import 'screens/main_shell.dart';
import 'screens/skin_profile_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const SkinSyncApp());
}

class SkinSyncApp extends StatelessWidget {
  const SkinSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skincare Routine',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/main': (context) => const MainShell(),
        '/skin-profile': (context) => const SkinProfileScreen(),
        '/add-diary-entry': (context) => const AddDiaryEntryScreen(),
      },
    );
  }
}
