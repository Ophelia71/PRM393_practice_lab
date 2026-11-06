# Lab 10.2 - Real API Login

Project chạy độc lập. Mở chính thư mục Lab10_2_RealApiLogin trong Android Studio.

## Cách chạy

1. Chạy `flutter pub get`.
2. Chọn emulator Android hoặc điện thoại.
3. Chạy `flutter run`.

Tài khoản kiểm thử: emilys / emilyspass (tài khoản demo công khai của DummyJSON)

## Thứ tự đọc code

1. main.dart: mở màn hình đăng nhập.
2. validators.dart: kiểm tra username và mật khẩu không rỗng.
3. models/app_user.dart: tên, email và access token.
4. services/auth_service.dart: POST /auth/login → đọc JSON → trả AppUser.
5. screens/login_screen.dart: nhập liệu, loading, lỗi và chuyển Home.
6. screens/home_screen.dart: hiển thị hồ sơ và quay lại Login khi đăng xuất.

## Điều cần hiểu

Bài này chưa lưu session. Không có SplashScreen hoặc kiểm tra /auth/me. http.Client có thể được thay bằng MockClient khi chạy test.

Tên biến: `_isLoading` cho biết đang xử lý; `_errorMessage` chứa lỗi; các biến kết thúc bằng `Controller` quản lý ô nhập (nếu có). Dấu `_` nghĩa là tên chỉ dùng trong thư viện Dart hiện tại. `await` chờ tác vụ hoàn tất; `mounted` kiểm tra màn hình còn tồn tại sau khi chờ.

## Kiểm tra

Nhập đúng/sai tài khoản; tắt Internet để kiểm tra lỗi; quan sát loading; đăng xuất và dùng Back.

Chạy `flutter analyze` và `flutter test`. Test API dùng MockClient, không gọi mạng thật. Cần chạy app với tài khoản mẫu để kiểm tra API thật.

## Nộp bài

Nén riêng thư mục project thành Lab10_2_RealApiLogin.zip.

