# Lab 10.1 - Mock Login

Project chạy độc lập. Mở chính thư mục Lab10_1_MockLogin trong Android Studio.

## Cách chạy

1. Chạy `flutter pub get`.
2. Chọn emulator Android hoặc điện thoại.
3. Chạy `flutter run`.

Tài khoản kiểm thử: student@example.com / 123456 (tài khoản mô phỏng)

## Thứ tự đọc code

1. main.dart: khởi động ứng dụng và mở LoginScreen.
2. validators.dart: kiểm tra email và mật khẩu.
3. models/app_user.dart: tên, email và token trả về sau đăng nhập.
4. services/auth_service.dart: chờ 700 ms, kiểm tra tài khoản và trả mock token.
5. screens/login_screen.dart: Form → gọi service → chuyển Home hoặc hiện lỗi.
6. screens/home_screen.dart: hiện tên/email; đăng xuất bằng cách quay về Login.

## Điều cần hiểu

Bài này chưa lưu phiên. Mở lại app sẽ vào Login. Home dùng StatelessWidget vì chỉ hiển thị dữ liệu.

Tên biến: `_isLoading` cho biết đang xử lý; `_errorMessage` chứa lỗi; các biến kết thúc bằng `Controller` quản lý ô nhập (nếu có). Dấu `_` nghĩa là tên chỉ dùng trong thư viện Dart hiện tại. `await` chờ tác vụ hoàn tất; `mounted` kiểm tra màn hình còn tồn tại sau khi chờ.

## Kiểm tra

Để trống form; nhập email sai định dạng; nhập sai mật khẩu; nhập đúng tài khoản mẫu; bấm lúc loading; đăng xuất và dùng Back.

Chạy `flutter analyze` và `flutter test`. Test kiểm tra validator, mock service và luồng giao diện đăng nhập/đăng xuất.

## Nộp bài

Nén riêng thư mục project thành Lab10_1_MockLogin.zip.

