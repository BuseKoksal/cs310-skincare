
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_spacing.dart';

class SkinProfileScreen extends StatefulWidget {
  const SkinProfileScreen({super.key});

  @override
  State<SkinProfileScreen> createState() =>
      _SkinProfileScreenState();
}

class _SkinProfileScreenState extends State<SkinProfileScreen> {
  String? selectedSkinType;

  final Set<String> selectedConcerns = {};

  final List<String> skinTypes = [
    'Dry',
    'Oily',
    'Combination',
    'Normal',
  ];

  final List<String> skinConcerns = [
    'Acne',
    'Dryness',
    'Redness',
    'Sensitivity',
    'Dark Spots',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text('Skin Profile'),
        backgroundColor: AppColors.background,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LOCAL SKINCARE IMAGE
              Center(
                child: Image.asset(
                  'assets/images/skincare.jpg',
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // PAGE TITLE
              Text(
                'Your Skin Profile',
                style: AppTextStyles.pageTitle.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              // DESCRIPTION
              const Text(
                'Tell us about your skin to personalize your routine.',
                style: AppTextStyles.bodyGray,
              ),

              const SizedBox(height: AppSpacing.xl),

              // SKIN TYPE TITLE
              Text(
                'What is your skin type?',
                style: AppTextStyles.subtitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // SKIN TYPE CHOICES
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,

                children: skinTypes.map((type) {
                  return ChoiceChip(
                    label: Text(type),
                    selected: selectedSkinType == type,
                    selectedColor: AppColors.sageSelected,

                    onSelected: (selected) {
                      setState(() {
                        selectedSkinType =
                        selected ? type : null;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: AppSpacing.xl),

              // SKIN CONCERNS TITLE
              Text(
                'What are your skin concerns?',
                style: AppTextStyles.subtitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // SKIN CONCERNS CHOICES
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,

                children: skinConcerns.map((concern) {
                  return FilterChip(
                    label: Text(concern),
                    selected:
                    selectedConcerns.contains(concern),
                    selectedColor: AppColors.sageSelected,

                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedConcerns.add(concern);
                        } else {
                          selectedConcerns.remove(concern);
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: AppSpacing.xl),

              // SAVE PROFILE BUTTON
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: selectedSkinType == null
                      ? null
                      : () {
                    showDialog(
                      context: context,

                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text(
                            'Profile Saved!',
                          ),

                          content: Text(
                            'Skin Type: $selectedSkinType\n'
                                'Concerns: ${selectedConcerns.isEmpty ? "None" : selectedConcerns.join(", ")}',
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  dialogContext,
                                );
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,

                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                  ),

                  child: const Text(
                    'Save Profile',
                    style: AppTextStyles.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
