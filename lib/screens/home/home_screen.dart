import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final void Function(int)? onNavigate;

  const HomeScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Home - coming soon')),
    );
  }
}
