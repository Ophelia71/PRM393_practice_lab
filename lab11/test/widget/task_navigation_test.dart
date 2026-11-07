import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/main.dart';
import 'package:lab11/repositories/task_repository.dart';

void main() {
  testWidgets('Chạm task mở Task Detail với đúng TextField key', (
    tester,
  ) async {
    // Arrange: seed repository bằng một task trước khi dựng màn hình.

    final repository = TaskRepository();
    repository.addTask('Seed task');
    await tester.pumpWidget(TasklyApp(repository: repository));

    await tester.tap(find.text('Seed task')); // Act
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(AppBar, 'Task Detail'),
      findsOneWidget,
    ); // Assert
    expect(find.byKey(const ValueKey('detailTitleField')), findsOneWidget);
  });
}
