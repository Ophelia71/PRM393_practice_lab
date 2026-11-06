# Lab 10.3 - Auto Login và Logout

Project chạy độc lập. Mở chính thư mục Lab10_3_AutoLogin_Logout trong Android Studio.

## Cách chạy

1. Chạy `flutter pub get`.
2. Chọn emulator Android hoặc điện thoại.
3. Chạy `flutter run`.

Tài khoản kiểm thử: emilys / emilyspass (tài khoản demo công khai của DummyJSON)

## Thứ tự đọc code

1. models/app_user.dart: thêm expiresAt, toJson và fromJson để lưu phiên.
2. services/auth_service.dart: đăng nhập API và kiểm tra token qua /auth/me.
3. services/session_storage.dart: lưu, đọc và xóa phiên bằng SharedPreferences.
4. screens/login_screen.dart: đăng nhập → lưu phiên → vào Home.
5. screens/splash_screen.dart: đọc phiên → kiểm tra token → chọn Login hoặc Home.
6. screens/home_screen.dart: xóa phiên rồi quay về Login khi đăng xuất.
7. main.dart: bắt đầu ở SplashScreen.

## Điều cần hiểu

Phần cơ bản theo đề là lưu token và đọc lại khi mở app. Bài này giữ thêm kiểm tra hạn 30 phút, JSON hỏng và /auth/me. Khi mất mạng, Splash cho thử lại hoặc xóa phiên để đăng nhập lại. Bài học chưa thêm refresh token.

Tên biến: `_isLoading` cho biết đang xử lý; `_errorMessage` chứa lỗi; các biến kết thúc bằng `Controller` quản lý ô nhập (nếu có). Dấu `_` nghĩa là tên chỉ dùng trong thư viện Dart hiện tại. `await` chờ tác vụ hoàn tất; `mounted` kiểm tra màn hình còn tồn tại sau khi chờ.

## Kiểm tra

Đăng nhập rồi đóng/mở app; logout rồi mở lại; thử mất mạng lúc khôi phục phiên; kiểm tra nút Back sau logout.

Chạy `flutter analyze` và `flutter test`. Test kiểm tra lưu/xóa phiên, phiên hết hạn hoặc hỏng, và phản hồi API giả bằng MockClient. Cần chạy app để kiểm tra đóng/mở và điều hướng thực tế.

SharedPreferences dùng theo yêu cầu lab. Không lưu mật khẩu; ứng dụng thực tế cần cân nhắc kho lưu trữ bảo mật cho token. Trên web, giữ cùng trình duyệt và địa chỉ/port khi thử khôi phục phiên.

## Nộp bài

Nén riêng thư mục project thành Lab10_3_AutoLogin_Logout.zip.
