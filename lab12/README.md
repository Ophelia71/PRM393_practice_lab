# Lab 12 — Taskly tối ưu hiệu năng

Mở thư mục lab12, chạy flutter pub get. Chọn Chrome để học UI, Android để đo profile/build APK.
Dữ liệu trong RAM như Lab 11, không có cơ sở dữ liệu hoặc backend.

## Đọc code theo thứ tự

1. models/task.dart và repositories/task_repository.dart giống nền tảng Lab 11.
2. providers/task_provider.dart: ChangeNotifier, notifyListeners.
3. widgets/task_tile.dart: Selector chọn đúng một Task.
4. screens/task_list_screen.dart: Selector cho list, ValueKey, const, precacheImage.
5. screens/before_task_list_screen.dart: bản đối chiếu watch ở cả màn hình.

Selector chỉ dựng lại phần UI phụ thuộc dữ liệu đã chọn. Model bất biến tạo đối tượng mới
khi sửa/toggle, giữ đối tượng cũ cho task không thay đổi. Không dùng context.watch ở toàn màn hình chính.

## Thực hành

Thêm task, toggle, sửa, xóa và +100 mẫu. Bấm biểu tượng so sánh trên AppBar để xem bản trước tối ưu.
Mở DevTools từ Run → Flutter DevTools trong Android Studio; bật theo dõi rebuild.
Chụp ảnh trước/sau với cùng dữ liệu, thao tác, thiết bị.

Chạy flutter analyze, flutter test. Test integration thật: flutter test integration_test -d <android-device-id>.
Profile: flutter run --profile -d <android-device-id>. Ghi FPS/jank thực tế, không dùng debug để kết luận tốc độ release.

## Build và size analysis

Chạy powershell -ExecutionPolicy Bypass -File tools/build_release.ps1 từ Terminal trong project.
Script clean, pub get, analyze, test rồi build APK release ARM64 với size analysis.
APK được lưu ở release/app-arm64-release.apk và build/app/outputs/flutter-apk/app-release.apk.
Phân tích JSON ở reports/size; mở bằng dart devtools --appSizeBase=<đường-dẫn-file-json>.
Build AAB nếu cần: flutter build appbundle --release.
Thiếu license Android: người dùng đọc/chấp nhận bằng flutter doctor --android-licenses.

Template hiện ký debug để cài thử; trước khi đưa lên store cần upload key/signing riêng.
Không có khóa ký cá nhân nào được tạo hoặc đưa vào project này.
Xem reports/LAB12_REPORT.pdf, reports/BUILD_STATUS.md, reports/PERFORMANCE_REPORT.md và reports/ASSET_COMPARISON.md.
Đã chạy integration test Android thành công và chụp ảnh bản release. FPS/jank và ảnh DevTools chưa được đo/chụp.

