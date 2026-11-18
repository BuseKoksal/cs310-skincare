import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final IconData? icon;
  final bool fullWidth;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 20),
          if (icon != null) const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.button,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: 50,
      child: button,
    );
  }
}
