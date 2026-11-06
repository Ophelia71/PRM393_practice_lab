import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab10_1_mock_login/main.dart';

void main() {
  testWidgets('Form báo lỗi khi chưa nhập thông tin', (tester) async {
    await tester.pumpWidget(const Lab10App());
    await tester.tap(find.text('Đăng nhập'));
    await tester.pump();

    expect(find.text('Hãy nhập email'), findsOneWidget);
    expect(find.text('Hãy nhập mật khẩu'), findsOneWidget);
    expect(find.text('Home'), findsNothing);
  });

  testWidgets('Tài khoản mẫu đi qua Form, vào Home và đăng xuất', (
    tester,
  ) async {
    await tester.pumpWidget(const Lab10App());
    await tester.enterText(
      find.byKey(const ValueKey('loginField')),
      'student@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('passwordField')),
      '123456',
    );
    await tester.tap(find.text('Đăng nhập'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );

    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.text('Đăng xuất'));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsNothing);
    expect(find.text('Đăng nhập'), findsOneWidget);
    expect(
      tester.state<NavigatorState>(find.byType(Navigator)).canPop(),
      isFalse,
    );
  });

  testWidgets('Sai mật khẩu hiển thị lỗi và cho phép thử lại', (tester) async {
    await tester.pumpWidget(const Lab10App());
    await tester.enterText(
      find.byKey(const ValueKey('loginField')),
      'student@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('passwordField')),
      '654321',
    );
    await tester.tap(find.text('Đăng nhập'));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();

    expect(find.text('Email hoặc mật khẩu không đúng.'), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
    expect(find.text('Home'), findsNothing);
  });
}
