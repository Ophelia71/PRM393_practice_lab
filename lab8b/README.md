# Lab 8B — Weather Companion App

Đây là project Flutter **riêng** cho Lab 8B. Tình huống được chọn là thời tiết:
chọn một trong ba thành phố, xem dữ liệu hiện tại từ Open-Meteo và đọc gợi ý
đơn giản như mang ô/áo mưa, áo khoác hoặc nước uống. Không cần API key.

## Chạy

Trong Android Studio, chọn **File → Open** và mở thư mục
`D:\FU\FA26\PRM393\practice_lab\lab8b` (thư mục có `pubspec.yaml`).
Chạy `flutter pub get`, chọn Chrome hoặc Android rồi chạy `lib/main.dart`.
Máy chạy app cần Internet. Android đã khai báo quyền Internet.

## Đọc code theo thứ tự

1. `lib/models/city.dart`: tên và tọa độ ba thành phố.
2. `lib/models/weather.dart`: `fromJson`, mô tả và quy tắc gợi ý.
3. `lib/services/api_service.dart`: tạo URL, GET, kiểm tra lỗi, giải mã JSON.
4. `lib/screens/weather_screen.dart`: chọn thành phố, loading, lỗi, retry, dữ liệu.
5. `lib/main.dart`: khởi động ứng dụng và gắn màn hình.

Luồng dữ liệu: **chọn thành phố → service gửi GET → JSON → Weather.fromJson →
FutureBuilder hiển thị**. `Future` được lưu trong `State`, nên mỗi lần `build()`
không tự gửi lại request. Mỗi file có comment tiếng Việt giải thích bước chính.

## Tự kiểm tra

```powershell
flutter analyze
flutter test
flutter run -d chrome
```

Để chụp màn hình nộp bài: chụp trạng thái đang tải, thành công, lỗi khi ngắt mạng,
và màn hình gợi ý thời tiết. Test dùng `MockClient`, không cần mạng thật.
Đây là project độc lập; Lab 8 cũ vẫn có tab 8B để tiện so sánh.

Nguồn API: https://open-meteo.com/en/docs ; dữ liệu Open-Meteo theo CC BY 4.0.
Gợi ý của app chỉ dựa trên thời tiết **hiện tại**, không phải dự báo cả ngày.
