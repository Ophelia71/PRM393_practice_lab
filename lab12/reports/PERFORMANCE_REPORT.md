# Báo cáo thực hành Lab 12

## 12.1 Giảm rebuild

Bản đối chiếu: lib/screens/before_task_list_screen.dart watch TaskProvider ở cả màn hình
và đặt ListTile inline. Bản tối ưu tách TaskTile, dùng Selector<TaskProvider, List<Task>>
cho khung danh sách, so sánh ID và dùng Selector riêng theo Task ở mỗi hàng.
Model bất biến giúp hàng không đổi giữ nguyên đối tượng. Có ValueKey(task.id),
const cho UI tĩnh, read cho action, bộ đếm hoàn thành chỉ theo dõi số lượng.

Đây là giải thích cấu trúc, chưa phải số liệu FPS đo trên thiết bị.
Mở bản trước/sau bằng nút so sánh, bật Track widget builds/Repaint Rainbow trong DevTools,
toggle cùng một task và chụp ảnh theo cùng kích thước thiết bị.

## 12.2 Asset

Ảnh gốc 1024×1024 nằm trong reports/assets-original.png để đối chiếu.
Ảnh chạy app 128×128 nằm trong assets/images/task_icon.png.
Chỉ ảnh 128×128 được đăng ký trong pubspec, có precacheImage trong didChangeDependencies.
Không có asset sẵn có nào bị xóa; ảnh gốc không được đóng gói vào app.
Kích thước byte và mức giảm được ghi trong ASSET_COMPARISON.md.

## 12.3 App size

Chạy tools/build_release.ps1 để tạo APK ARM64 và file phân tích JSON thực tế.
Flutter hiện xuất JSON để mở trong DevTools App Size; không giả tạo báo cáo HTML.
Đã build APK ARM64, dung lượng và top 3 thành phần thực tế nằm trong BUILD_STATUS.md.
Ghi số thực sau khi build, chụp DevTools App Size và xem Flutter engine, Dart AOT,
assets/thư viện native nào chiếm nhiều nhất trước khi quyết định loại bỏ dependency.

## 12.4 Profile và release

- Code đã tách widget và giới hạn nơi theo dõi state.
- Dùng ListView.builder và icon nhỏ, không có print/debug log trong luồng chạy app.
- Cần đo FPS/jank trên Android với flutter run --profile.
- Đã cài và mở APK release ARM64 trên emulator, thêm 100 task mẫu và chụp ảnh reports/screenshots/taskly-release.png.
- Android template hiện ký debug để học và cài thử. Muốn phát hành lên Google Play
  phải tạo upload key, cấu hình signing release, applicationId và thông tin phát hành.

Đây là bản thực hành chuẩn bị build và đo đạc; chưa tuyên bố sẵn sàng phát hành lên store.

