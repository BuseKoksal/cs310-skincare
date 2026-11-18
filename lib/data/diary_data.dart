import '../models/diary_entry.dart';

class DiaryData {
  static List<DiaryEntry> entries = [
    DiaryEntry(
      id: 1,
      date: DateTime.now().subtract(const Duration(days: 1)),
      rating: 4,
      note: 'Skin felt hydrated',
    ),
    DiaryEntry(
      id: 2,
      date: DateTime.now().subtract(const Duration(days: 3)),
      rating: 3,
      note: 'Skin looked a bit dry',
    ),
    DiaryEntry(
      id: 3,
      date: DateTime.now().subtract(const Duration(days: 12)),
      rating: 5,
      note: 'Skin looked clear',
    ),
  ];
}
