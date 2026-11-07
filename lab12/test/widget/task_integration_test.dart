import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab12/main.dart';

// Theo đường dẫn đề bài: đây là full flow chạy trong môi trường widget test.
// Bản integration_test/ riêng bên ngoài test/ chạy với engine trên thiết bị thật.
void main() {
  testWidgets('Full flow: add -> detail -> edit -> save -> list', (
    tester,
  ) async {
    await tester.pumpWidget(const TasklyApp());
    await tester.enterText(
      find.byKey(const ValueKey('addTaskField')),
      'Original title',
    );
    await tester.tap(find.byKey(const ValueKey('addTaskButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Original title'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('detailTitleField')),
      'Updated title',
    );
    await tester.tap(find.byKey(const ValueKey('saveTaskButton')));
    await tester.pumpAndSettle();
    expect(find.text('Updated title'), findsOneWidget);
    expect(find.text('Original title'), findsNothing);
  });
}
