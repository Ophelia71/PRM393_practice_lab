import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<String> showMessage(String message) async {
    // Bài LO7 này trình diễn thông báo hệ thống Android, không thay bằng SnackBar.
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return 'Hãy chạy trên Android để xem thông báo hệ thống của bài này.';
    }
    if (!_isInitialized) {
      await _notificationsPlugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('ic_notification'),
        ),
      );
      _isInitialized = true;
    }
    final android = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    // Android 13+ yêu cầu quyền runtime. Từ chối quyền không làm app crash.
    final allowed = await android?.requestNotificationsPermission() ?? false;
    if (!allowed) {
      return 'Chưa được cấp quyền. Bạn có thể bật thông báo trong Cài đặt ứng dụng.';
    }
    await _notificationsPlugin.show(
      id: 10,
      title: 'Lab 10 - Thành công',
      body: message,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'lab10_actions',
          'Hoạt động người dùng',
          channelDescription: 'Thông báo sau khi đăng nhập hoặc bấm thử',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
    return 'Đã gửi yêu cầu hiển thị thông báo. Kéo thanh thông báo Android xuống để kiểm tra.';
  }
}
