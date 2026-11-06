import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lab10_full/models/app_user.dart';
import 'package:lab10_full/services/auth_service.dart';

AppUser createUser({bool expired = false}) {
  return AppUser(
    name: 'Student',
    email: 'student@example.com',
    token: 'saved-token',
    expiresAt: expired ? DateTime(2000) : DateTime(2099),
  );
}

void main() {
  test('Phiên hợp lệ gửi đúng Bearer token tới /auth/me', () async {
    final authService = AuthService(
      client: MockClient((request) async {
        expect(request.url.path, '/auth/me');
        expect(request.headers['Authorization'], 'Bearer saved-token');
        return http.Response('{}', 200);
      }),
    );
    addTearDown(authService.close);
    expect(await authService.validateSession(createUser()), isTrue);
  });

  test('Token bị máy chủ từ chối không được auto-login', () async {
    final authService = AuthService(
      client: MockClient((_) async => http.Response('{}', 401)),
    );
    addTearDown(authService.close);
    expect(await authService.validateSession(createUser()), isFalse);
  });

  test('Phiên hết hạn bị từ chối trước khi gọi mạng', () async {
    final authService = AuthService(
      client: MockClient((_) async {
        fail('Không được gọi API khi phiên đã hết hạn');
      }),
    );
    addTearDown(authService.close);
    expect(
      await authService.validateSession(createUser(expired: true)),
      isFalse,
    );
  });

  test('Lỗi mạng được báo riêng, không coi token là không hợp lệ', () async {
    final authService = AuthService(
      client: MockClient((_) async => throw http.ClientException('offline')),
    );
    addTearDown(authService.close);
    await expectLater(
      authService.validateSession(createUser()),
      throwsException,
    );
  });
}
