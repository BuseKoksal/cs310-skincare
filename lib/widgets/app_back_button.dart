import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(foregroundColor: AppColors.textDark),
      icon: const Icon(Icons.chevron_left, size: 20),
      label: const Text('Back'),
    );
  }
}
