# Lab 9 — Đọc và lưu JSON cục bộ

Mở thư mục lab9 trong Android Studio, chạy flutter pub get, chọn Android rồi Run.
Chrome chỉ hỗ trợ tab 9.1; tab 9.2/9.3 cần file trên thiết bị và path_provider.

## Ba bài thực hành

- 9.1: rootBundle.loadString đọc assets/data/products.json, hiển thị tên và ghi chú.
- 9.2: bấm + để thêm; bấm Lưu JSON trước khi đóng app. Đọc lại file để xác minh.
- 9.3: thêm bằng +, chạm một mục để sửa, nút thùng rác để xóa có xác nhận; tìm theo tên/ghi chú. Tự lưu sau mỗi thay đổi.

Đường dẫn file được hiển thị ở cuối mỗi tab. File nằm trong application documents directory.
Asset đóng gói chỉ đọc; notes.json/database.json mới là file có thể ghi.
Nếu lưu lỗi, màn hình giữ thay đổi và cho bấm Lưu JSON lần nữa. Nếu đọc lỗi, không tự xóa file.
Dữ liệu còn sau khi đóng/mở app; gỡ ứng dụng hoặc Clear data sẽ xóa dữ liệu.

## Đọc code theo thứ tự

1. models/local_item.dart: constructor, fromJson, toJson.
2. services/json_storage.dart: path_provider, File, jsonDecode/JsonEncoder, async/await.
3. screens/asset_screen.dart: tải asset bằng FutureBuilder.
4. screens/storage_screen.dart: setState, thêm/sửa/xóa, lưu và tìm kiếm.
5. main.dart: kết nối ba tab.

Trong code, final là biến chỉ gán một lần; Future là kết quả sẽ có sau; await chờ tác vụ mà không khóa UI; mounted kiểm tra màn hình còn tồn tại trước khi cập nhật UI.

## Tự kiểm tra

Chạy flutter analyze và flutter test. Test sử dụng thư mục tạm riêng, không chạm dữ liệu ứng dụng.
Thêm dữ liệu ở tab 9.2, lưu, tắt/mở app. Ở tab 9.3 thử thêm, sửa, tìm, xóa và khởi động lại.
Chụp ảnh ba tab và lưu/đọc lại để nộp theo đề.

Tài liệu: https://pub.dev/packages/path_provider

