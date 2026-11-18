import 'package:flutter/material.dart';

import '../models/diary_entry.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';
import '../utils/date_utils.dart';

class DiaryEntryCard extends StatelessWidget {
  final DiaryEntry entry;
  final void Function() onDelete;

  const DiaryEntryCard({
    super.key,
    required this.entry,
    required this.onDelete,
  });

  IconData _moodIcon() {
    if (entry.rating >= 4) {
      return Icons.sentiment_very_satisfied;
    } else if (entry.rating == 3) {
      return Icons.sentiment_neutral;
    }
    return Icons.sentiment_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.sandBeige,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
              ),
              child: Icon(_moodIcon(), color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateHelper.formatDate(entry.date),
                    style: AppTextStyles.cardTitle,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${entry.rating}/5 - ${entry.note}',
                    style: AppTextStyles.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, color: AppColors.textDark),
            ),
          ],
        ),
      ),
    );
  }
}
