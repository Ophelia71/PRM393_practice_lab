# Lab 10.4 - Firebase Google Sign-In

Project chạy độc lập. Mở chính thư mục Lab10_4_FirebaseGoogleSignIn trong Android Studio.

## Cách chạy

1. Chạy `flutter pub get`.
2. Chọn emulator Android hoặc điện thoại.
3. Chạy `flutter run`.

Cấu hình Google Sign-In theo FIREBASE_SETUP.md trước khi kiểm tra chức năng Google.

Tài khoản kiểm thử: Dùng tài khoản Google của bạn sau khi hoàn thành FIREBASE_SETUP.md.

## Thứ tự đọc code

1. FIREBASE_SETUP.md: cấu hình Firebase, Google provider và SHA keys.
2. main.dart: khởi tạo Firebase trước khi mở app.
3. models/app_user.dart: chỉ chứa tên và email để hiển thị hồ sơ.
4. services/google_auth_service.dart: đăng nhập, khôi phục và đăng xuất Firebase/Google.
5. screens/splash_screen.dart: chờ Firebase đọc phiên rồi chọn màn hình.
6. screens/login_screen.dart: nút đăng nhập Google, loading và thông báo lỗi.
7. screens/home_screen.dart: hiển thị hồ sơ và đăng xuất.

## Điều cần hiểu

Firebase tự lưu phiên Google; không cần lưu token Google vào SharedPreferences. firebase_options.dart vẫn là file chờ cấu hình thật. Khi chưa cấu hình, app báo hướng dẫn và không giả lập đăng nhập thành công.

Tên biến: `_isLoading` cho biết đang đăng nhập; `_errorMessage` chứa lỗi. Dấu `_` nghĩa là tên chỉ dùng trong thư viện Dart hiện tại. `await` chờ tác vụ hoàn tất; `mounted` kiểm tra màn hình còn tồn tại sau khi chờ.

## Kiểm tra

Sau khi cấu hình: đăng nhập Google; hủy chọn tài khoản; đóng/mở app; đăng xuất; kiểm tra không quay lại Home bằng Back.

Chạy `flutter analyze` và `flutter test`. Test hiện kiểm tra nhánh chưa cấu hình Firebase. Phải kiểm tra Google login, khôi phục phiên và logout thực tế sau khi cấu hình Firebase.

## Nộp bài

Nén riêng thư mục project thành Lab10_4_FirebaseGoogleSignIn.zip.

