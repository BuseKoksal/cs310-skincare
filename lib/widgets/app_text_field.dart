import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int maxLines;

  const AppTextField({
    super.key,
    this.controller,
    required this.hint,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
