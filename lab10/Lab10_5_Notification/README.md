# Lab 10.5 - Local Notification

Project chạy độc lập. Mở chính thư mục Lab10_5_Notification trong Android Studio.

## Cách chạy

1. Chạy `flutter pub get`.
2. Chọn emulator Android hoặc điện thoại.
3. Chạy `flutter run`.

Tài khoản kiểm thử: Không cần tài khoản.

## Thứ tự đọc code

1. lib/main.dart: nút gửi thông báo, loading và nội dung kết quả.
2. lib/services/notification_service.dart: kiểm tra Android → khởi tạo plugin → xin quyền → gửi thông báo.
3. android/app/src/main/AndroidManifest.xml: quyền POST_NOTIFICATIONS.
4. android/app/build.gradle.kts: Java 17 và desugaring cho plugin.

## Điều cần hiểu

Chạy trên Android API 33+ để kiểm tra quyền runtime. Chrome chỉ hiện lời nhắc chạy Android. Đã giữ cấu hình channel, icon và desugaring. Tham số có tên settings/id/title/body/notificationDetails đúng với plugin phiên bản 22 của project.

Tên biến: `_isLoading` cho biết đang gửi; `_statusMessage` chứa kết quả; `_notificationService` xử lý thông báo. Dấu `_` nghĩa là tên chỉ dùng trong thư viện Dart hiện tại. `await` chờ tác vụ hoàn tất; `mounted` kiểm tra màn hình còn tồn tại sau khi chờ.

## Kiểm tra

Bấm Hiện thông báo; cấp quyền và kiểm tra thanh thông báo; thử từ chối quyền; bật lại quyền trong Cài đặt ứng dụng.

Chạy `flutter analyze` và `flutter test`. Test chỉ kiểm tra nhánh không hỗ trợ Android. Phải kiểm tra thông báo thật trên thiết bị hoặc emulator Android.

## Nộp bài

Nén riêng thư mục project thành Lab10_5_Notification.zip.

