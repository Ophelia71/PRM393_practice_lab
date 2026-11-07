import 'package:provider/provider.dart';
import 'package:lab12/providers/task_provider.dart';
import 'package:lab12/screens/task_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab12/repositories/task_repository.dart';

void main() {
  testWidgets('Chạm task mở Task Detail với đúng TextField key', (
    tester,
  ) async {
    // Arrange: seed repository bằng một task trước khi dựng màn hình.

    final repository = TaskRepository();
    repository.addTask('Seed task');
    final provider = TaskProvider(repository: repository);
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: const MaterialApp(home: TaskListScreen()),
      ),
    );
    addTearDown(provider.dispose);

    await tester.tap(find.text('Seed task')); // Act
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(AppBar, 'Task Detail'),
      findsOneWidget,
    ); // Assert
    expect(find.byKey(const ValueKey('detailTitleField')), findsOneWidget);
  });
}
