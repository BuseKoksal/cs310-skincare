import 'package:flutter/material.dart';

import '../../data/diary_data.dart';
import '../../models/diary_entry.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/diary_entry_card.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final List<String> filterOptions = ['All entries', 'Last 7 days', 'Last 30 days'];
  String selectedFilter = 'All entries';

  List<DiaryEntry> _filteredEntries() {
    final now = DateTime.now();
    final result = DiaryData.entries.where((entry) {
      final daysAgo = now.difference(entry.date).inDays;
      if (selectedFilter == 'Last 7 days') {
        return daysAgo < 7;
      } else if (selectedFilter == 'Last 30 days') {
        return daysAgo < 30;
      }
      return true;
    }).toList();

    // newest first
    result.sort((a, b) => b.date.compareTo(a.date));
    return result;
  }

  Future<void> _openNewEntry() async {
    final result = await Navigator.pushNamed(context, '/add-diary-entry');
    if (!mounted) return;

    if (result is DiaryEntry) {
      setState(() {
        DiaryData.entries.add(result);
      });
    }
  }

  void _confirmDelete(DiaryEntry entry) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: const Text('Delete entry?', style: AppTextStyles.sectionTitle),
          content: const Text(
            'This diary entry will be removed.',
            style: AppTextStyles.body,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                setState(() {
                  DiaryData.entries.remove(entry);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Entry deleted')),
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: const Text('Filter by date', style: AppTextStyles.sectionTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: filterOptions.map((option) {
              return ListTile(
                title: Text(option, style: AppTextStyles.body),
                trailing: selectedFilter == option
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() {
                    selectedFilter = option;
                  });
                  Navigator.pop(dialogContext);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = _filteredEntries();

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: _openNewEntry,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text('Skin Diary', style: AppTextStyles.pageTitle),
                  ),
                  GestureDetector(
                    onTap: _showFilterDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightSage,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.filter_alt_outlined, size: 16),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            selectedFilter == 'All entries' ? 'Filter' : selectedFilter,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: entries.isEmpty
                    ? const Center(
                        child: Text(
                          'No entries yet.\nTap + to add how your skin feels today.',
                          style: AppTextStyles.bodyGray,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          final entry = entries[index];
                          return DiaryEntryCard(
                            entry: entry,
                            onDelete: () => _confirmDelete(entry),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
