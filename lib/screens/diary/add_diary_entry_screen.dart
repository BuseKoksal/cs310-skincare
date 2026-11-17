import 'package:flutter/material.dart';

class AddDiaryEntryScreen extends StatelessWidget {
  const AddDiaryEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Entry')),
      body: const Center(child: Text('New Entry - coming soon')),
    );
  }
}
