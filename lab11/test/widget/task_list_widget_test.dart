import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/main.dart';

void main() {
  testWidgets('Empty State hiển thị đúng thông báo', (tester) async {
    await tester.pumpWidget(TasklyApp()); // Arrange
    expect(find.text('No tasks yet. Add one!'), findsOneWidget); // Assert
  });
  testWidgets('Thêm một task làm UI cập nhật', (tester) async {
    await tester.pumpWidget(TasklyApp()); // Arrange
    await tester.enterText(
      find.byKey(const ValueKey('addTaskField')),
      'Học Flutter',
    ); // Act
    await tester.tap(find.byKey(const ValueKey('addTaskButton')));
    await tester.pump();
    expect(find.text('Học Flutter'), findsOneWidget); // Assert
    expect(find.text('No tasks yet. Add one!'), findsNothing);
  });
  testWidgets('Hai task đều xuất hiện', (tester) async {
    await tester.pumpWidget(TasklyApp());
    for (final title in ['Task A', 'Task B']) {
      await tester.enterText(find.byKey(const ValueKey('addTaskField')), title);
      await tester.tap(find.byKey(const ValueKey('addTaskButton')));
      await tester.pump();
    }
    expect(find.text('Task A'), findsOneWidget);
    expect(find.text('Task B'), findsOneWidget);
  });
  testWidgets('Không thêm tiêu đề trống', (tester) async {
    await tester.pumpWidget(TasklyApp());
    await tester.tap(find.byKey(const ValueKey('addTaskButton')));
    await tester.pump();
    expect(find.text('Hãy nhập tiêu đề.'), findsOneWidget);
    expect(find.text('No tasks yet. Add one!'), findsOneWidget);
  });
}
