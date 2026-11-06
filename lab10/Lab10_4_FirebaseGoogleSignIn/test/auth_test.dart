import 'package:flutter_test/flutter_test.dart';
import 'package:lab10_4_firebase_google_sign_in/services/google_auth_service.dart';

void main() {
  test(
    'Chưa cấu hình Firebase thì không giả lập Google login thành công',
    () async {
      final authService = GoogleAuthService();
      expect(await authService.restore(), isNull);
      await expectLater(authService.signIn(), throwsStateError);
      await authService.signOut();
    },
  );
}
