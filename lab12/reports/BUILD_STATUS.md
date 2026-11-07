# Kết quả build APK Lab 12

Đã build thành công APK release ARM64 có phân tích dung lượng.
APK được lưu ổn định ở release/app-arm64-release.apk, dung lượng 16,930,897 bytes (16.15 MiB).

Ba mục chiếm nhiều dung lượng nén nhất trong APK:

- lib/arm64-v8a/libflutter.so: 11,747,864 bytes nén; 11,747,864 bytes giải nén.
- lib/arm64-v8a/libapp.so: 4,653,960 bytes nén; 4,653,960 bytes giải nén.
- classes.dex: 238,029 bytes nén; 520,156 bytes giải nén.

Đây là dung lượng thành phần trong ZIP/APK; xem thêm báo cáo JSON trong reports/size bằng DevTools App Size để phân tích cây Dart AOT.
APK dùng chữ ký debug của Flutter template để cài thử, chưa cấu hình upload key để phát hành store.
Chưa đo FPS/jank trên profile hoặc chụp DevTools. Không suy ra hiệu năng runtime từ kích thước APK.

Lỗi Java loopback ở môi trường công cụ đã được xử lý bằng thư mục socket Java ngắn theo process; không đổi cấu hình Java toàn máy.
