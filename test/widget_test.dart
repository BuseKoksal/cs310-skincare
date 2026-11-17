import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skincare_routine/main.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(const SkinSyncApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
