import 'package:flutter/material.dart';

import '../../models/diary_entry.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/date_utils.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

class AddDiaryEntryScreen extends StatefulWidget {
  const AddDiaryEntryScreen({super.key});

  @override
  State<AddDiaryEntryScreen> createState() => _AddDiaryEntryScreenState();
}

class _AddDiaryEntryScreenState extends State<AddDiaryEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();

  DateTime? selectedDate;
  int? selectedRating;

  String? dateError;
  String? ratingError;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (!mounted) return;

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateError = null;
      });
    }
  }

  void _saveEntry() {
    // date and rating are not text fields, so we check them here
    setState(() {
      dateError = selectedDate == null ? 'Please select a date' : null;
      ratingError =
          selectedRating == null ? 'Please rate how your skin feels' : null;
    });

    final noteIsValid = _formKey.currentState!.validate();
    if (!noteIsValid || dateError != null || ratingError != null) {
      return;
    }

    final newEntry = DiaryEntry(
      id: DateTime.now().millisecondsSinceEpoch,
      date: selectedDate!,
      rating: selectedRating!,
      note: _noteController.text.trim(),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: const Text('Entry Saved', style: AppTextStyles.sectionTitle),
          content: Text(
            'Your entry for ${DateHelper.formatDate(newEntry.date)} '
            '(${newEntry.rating}/5) was added to your skin diary.',
            style: AppTextStyles.body,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pop(context, newEntry);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBackButton(),
                const SizedBox(height: AppSpacing.sm),
                const Text('New Entry', style: AppTextStyles.pageTitle),
                const SizedBox(height: AppSpacing.lg),

                const Text('Date', style: AppTextStyles.cardTitle),
                const SizedBox(height: AppSpacing.sm),
                GestureDetector(
                  onTap: _pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSpacing.radius),
                      border: Border.all(
                        color: dateError != null ? AppColors.error : AppColors.border,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedDate == null
                                ? 'Select Date'
                                : DateHelper.formatDate(selectedDate!),
                            style: selectedDate == null
                                ? AppTextStyles.bodyGray
                                : AppTextStyles.body,
                          ),
                        ),
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                          color: AppColors.textDark,
                        ),
                      ],
                    ),
                  ),
                ),
                if (dateError != null) _errorText(dateError!),
                const SizedBox(height: AppSpacing.lg),

                const Text('How does your skin feel?', style: AppTextStyles.cardTitle),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [1, 2, 3, 4, 5].map((value) {
                    final isSelected = selectedRating == value;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRating = value;
                          ratingError = null;
                        });
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : AppColors.lightSage,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$value',
                          style: AppTextStyles.cardTitle.copyWith(
                            color: isSelected ? AppColors.white : AppColors.textDark,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (ratingError != null) _errorText(ratingError!),
                const SizedBox(height: AppSpacing.lg),

                const Text('Note', style: AppTextStyles.cardTitle),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _noteController,
                  hint: 'Write a short note..',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please write a short note';
                    }
                    if (value.trim().length < 5) {
                      return 'Note must be at least 5 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.xl),

                PrimaryButton(label: 'Save Entry', onPressed: _saveEntry),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _errorText(String message) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.md, top: 6),
      child: Text(message, style: AppTextStyles.error),
    );
  }
}
