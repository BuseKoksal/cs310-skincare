import 'package:flutter/material.dart';

class RoutineScreen extends StatelessWidget {
  final void Function()? onAddProduct;

  const RoutineScreen({super.key, this.onAddProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Routine')),
      body: const Center(child: Text('My Routine - coming soon')),
    );
  }
}
