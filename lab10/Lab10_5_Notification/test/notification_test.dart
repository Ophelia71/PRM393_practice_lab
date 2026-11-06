import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab10_5_notification/services/notification_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Nền tảng không phải Android được giải thích rõ, không giả thông báo thành công', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    addTearDown(() {
      debugDefaultTargetPlatformOverride = null;
    });
    expect(
      await NotificationService().showMessage('Demo'),
      contains('Android'),
    );
  });
}
