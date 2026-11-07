import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab12/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Luồng đầu cuối trên thiết bị', (tester) async {
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
