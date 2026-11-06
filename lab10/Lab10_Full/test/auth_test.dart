import 'package:flutter_test/flutter_test.dart';
import 'package:lab10_full/models/app_user.dart';
import 'package:lab10_full/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lab10_full/services/session_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Model session chuyển JSON hai chiều', () {
    final user = AppUser(
      name: 'Student',
      email: 'a@b.com',
      token: 'test-token',
      expiresAt: DateTime(2099),
    );
    final restored = AppUser.fromJson(user.toJson());
    expect(restored.token, user.token);
    expect(restored.expiresAt, user.expiresAt);
  });
  test('Model từ chối JSON sai', () {
    expect(() => AppUser.fromJson({}), throwsFormatException);
  });

  test('Form không chấp nhận trường rỗng', () {
    expect(validateLogin(''), isNotNull);
    expect(validatePassword(''), isNotNull);
  });

  test('Lưu/khôi phục/đăng xuất phiên', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = SessionStorage();
    expect(await storage.load(), isNull);
    await storage.save(
      AppUser(
        name: 'Student',
        email: 'a@b.com',
        token: 'test-token',
        expiresAt: DateTime(2099),
      ),
    );
    expect((await storage.load())!.name, 'Student');
    await storage.clear();
    expect(await storage.load(), isNull);
  });
  test('Phiên hết hạn hoặc JSON hỏng không auto-login', () async {
    SharedPreferences.setMockInitialValues({'lab10_session': 'broken'});
    final storage = SessionStorage();
    expect(await storage.load(), isNull);
    await storage.save(
      AppUser(
        name: 'Old',
        email: 'a@b.com',
        token: 'old',
        expiresAt: DateTime(2000),
      ),
    );
    expect(await storage.load(), isNull);
  });
}
