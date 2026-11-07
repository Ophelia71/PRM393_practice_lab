import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:lab12/providers/task_provider.dart';
import 'package:lab12/screens/task_list_screen.dart';

void main() {
  testWidgets('Toggle chỉ dựng lại ListTile có dữ liệu đổi', (tester) async {
    // Arrange: giữ lại hai ListTile đã được dựng trước khi thay đổi dữ liệu.
    final provider = TaskProvider();
    provider.addTask('A');
    provider.addTask('B');
    addTearDown(provider.dispose);
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: const MaterialApp(home: TaskListScreen()),
      ),
    );
    await tester.pumpAndSettle();
    final before = tester.widgetList<ListTile>(find.byType(ListTile)).toList();

    // Act: chỉ thay đổi task A, giữ nguyên task B.
    provider.toggleTask(provider.tasks.first.id);
    await tester.pump();
    final after = tester.widgetList<ListTile>(find.byType(ListTile)).toList();

    // Assert: A có widget mới; B dùng lại đúng ListTile đã cache trong Selector.
    expect(identical(before.first, after.first), isFalse);
    expect(identical(before.last, after.last), isTrue);
    expect((after.first.leading! as Checkbox).value, isTrue);
  });
}
