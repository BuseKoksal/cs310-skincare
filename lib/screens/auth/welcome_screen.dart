import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Text(
                'Welcome to Skincare Routine',
                textAlign: TextAlign.center,
                style: AppTextStyles.pageTitle,
              ),
              const Spacer(),
              Text(
                'Get Started',
                style: AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: 'Create Account',
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: 'Log in',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}