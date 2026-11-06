import 'package:flutter_test/flutter_test.dart';
import 'package:lab10_2_real_api_login/validators.dart';

void main() {
  test('Username và mật khẩu không được để trống', () {
    expect(validateLogin(''), isNotNull);
    expect(validateLogin('   '), isNotNull);
    expect(validatePassword(''), isNotNull);
  });

  test('Tài khoản API mẫu vượt qua validation', () {
    expect(validateLogin('emilys'), isNull);
    expect(validatePassword('emilyspass'), isNull);
  });
}
