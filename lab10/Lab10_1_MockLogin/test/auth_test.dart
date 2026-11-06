import 'package:flutter_test/flutter_test.dart';
import 'package:lab10_1_mock_login/validators.dart';
import 'package:lab10_1_mock_login/services/auth_service.dart';

void main() {
  test('Email mẫu hợp lệ, kể cả khi có khoảng trắng ở hai đầu', () {
    expect(validateLogin('student@example.com'), isNull);
    expect(validateLogin('  student@example.com  '), isNull);
  });

  test('Email sai định dạng bị từ chối', () {
    for (final email in ['', 'student', 'a b@c.com', 'a@bXcom']) {
      expect(validateLogin(email), isNotNull, reason: email);
    }
  });

  test('Mật khẩu phải có ít nhất 6 ký tự', () {
    expect(validatePassword(''), isNotNull);
    expect(validatePassword('123'), isNotNull);
    expect(validatePassword('123456'), isNull);
  });

  test('Mock trả token khi đúng tài khoản và báo lỗi khi sai', () async {
    final authService = AuthService();
    final user = await authService.login('student@example.com', '123456');
    expect(user.email, 'student@example.com');
    expect(user.token, isNotEmpty);
    await expectLater(
      authService.login('student@example.com', 'wrong'),
      throwsException,
    );
  });
}
