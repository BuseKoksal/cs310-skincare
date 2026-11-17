
import 'screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'screens/skin_profile_screen.dart';
void main() {
  runApp(const SkinSyncApp());
}

class SkinSyncApp extends StatelessWidget {
  const SkinSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkinSync',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF638568),
        ),
      ),
      home: const SkinProfileScreen(),
    );
  }
}
