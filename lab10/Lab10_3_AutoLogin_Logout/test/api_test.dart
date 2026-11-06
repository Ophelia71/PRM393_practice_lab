import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lab10_3_auto_login_logout/services/auth_service.dart';

void main() {
  test('POST gửi đúng dữ liệu, đọc accessToken từ API', () async {
    final auth = AuthService(
      client: MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/auth/login');
        expect(jsonDecode(request.body)['username'], 'emilys');
        return http.Response(
          '{"username":"emilys","email":"demo@example.com","accessToken":"sample"}',
          200,
        );
      }),
    );
    addTearDown(auth.close);
    expect((await auth.login('emilys', 'emilyspass')).token, 'sample');
  });
  for (final status in [400, 401, 500]) {
    test('HTTP $status báo lỗi', () async {
      final auth = AuthService(
        client: MockClient((_) async => http.Response('{}', status)),
      );
      addTearDown(auth.close);
      await expectLater(auth.login('x', 'y'), throwsException);
    });
  }
  test('Phản hồi thành công nhưng thiếu token bị từ chối', () async {
    final auth = AuthService(
      client: MockClient((_) async => http.Response('{}', 200)),
    );
    addTearDown(auth.close);
    await expectLater(auth.login('x', 'y'), throwsFormatException);
  });
}
