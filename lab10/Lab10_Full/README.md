# Lab 10 Full - Tích hợp

Project chạy độc lập. Mở chính thư mục Lab10_Full trong Android Studio.

## Cách chạy

1. Chạy `flutter pub get`.
2. Chọn emulator Android hoặc điện thoại.
3. Chạy `flutter run`.

Cấu hình Google Sign-In theo FIREBASE_SETUP.md trước khi kiểm tra chức năng Google.

Tài khoản kiểm thử: API: emilys / emilyspass. Google: dùng tài khoản của bạn sau khi cấu hình Firebase.

## Thứ tự đọc code

1. main.dart: khởi tạo Firebase và mở SplashScreen.
2. models/app_user.dart: dữ liệu người dùng và phiên; source phân biệt api/google.
3. services/auth_service.dart và session_storage.dart: đăng nhập API và lưu phiên.
4. services/google_auth_service.dart: Firebase tự quản lý phiên Google.
5. screens/splash_screen.dart: khôi phục phiên API hoặc Google rồi điều hướng.
6. screens/login_screen.dart: hai cách đăng nhập dùng chung _openHome để lưu phiên và gửi notification.
7. services/notification_service.dart: cùng phương thức showMessage như bài 10.5.
8. screens/home_screen.dart: hồ sơ, trạng thái thông báo và logout.

## Điều cần hiểu

Chỉ lưu phiên API vào SharedPreferences; Firebase tự quản lý phiên Google. Notification lỗi hoặc bị từ chối quyền vẫn cho vào Home sau login thành công. Phiên API được kiểm tra hạn và /auth/me; chưa thêm refresh token. Google vẫn cần cấu hình thật theo FIREBASE_SETUP.md.

Tên biến: `_isLoading` cho biết đang xử lý; `_errorMessage` chứa lỗi; các biến kết thúc bằng `Controller` quản lý ô nhập (nếu có). Dấu `_` nghĩa là tên chỉ dùng trong thư viện Dart hiện tại. `await` chờ tác vụ hoàn tất; `mounted` kiểm tra màn hình còn tồn tại sau khi chờ.

## Kiểm tra

Thử login API đúng/sai; login Google; đóng/mở app; logout và Back; cấp/từ chối quyền notification; kiểm tra thông báo sau cả hai cách login.

Chạy `flutter analyze` và `flutter test`. Test kiểm tra API và session bằng dữ liệu giả. Google Sign-In và notification hệ thống phải được kiểm tra thực tế trên Android sau khi cấu hình Firebase.

SharedPreferences dùng theo yêu cầu lab. Không lưu mật khẩu; ứng dụng thực tế cần cân nhắc kho lưu trữ bảo mật cho token. Trên web, giữ cùng trình duyệt và địa chỉ/port khi thử khôi phục phiên.

## Nộp bài

Nén riêng thư mục project thành Lab10_Full.zip.
