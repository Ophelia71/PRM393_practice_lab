# Kết nối Firebase thật

Project hiện có đầy đủ flow Google Sign-In nhưng chưa gắn tài khoản Firebase.
File lib/firebase_options.dart hiện báo thiếu cấu hình, không chứa API key giả.

1. Vào https://console.firebase.google.com/ và tạo một project.
2. Mở Terminal trong đúng project Flutter này. Package Android hiện tại: com.example.lab10_4_firebase_google_sign_in.
   Nếu đổi package, sửa namespace/applicationId và đường dẫn MainActivity trước khi đăng ký Firebase.
3. Cài Firebase CLI theo https://firebase.google.com/docs/cli, rồi chạy firebase login.
4. Chạy dart pub global activate flutterfire_cli.
5. Chạy flutterfire configure --platforms=android,web và chọn Firebase project vừa tạo.
   CLI sẽ thay lib/firebase_options.dart bằng cấu hình của bạn; giữ lệnh initializeApp hiện có.
6. Firebase Console → Authentication → Sign-in method → bật Google, chọn email hỗ trợ.
7. Từ thư mục android chạy .\gradlew signingReport. Thêm SHA-1 và SHA-256 của bản debug
   vào Firebase Console → Project settings → Android app.
8. Tải google-services.json đã cập nhật vào android/app/google-services.json.
   Chạy lại flutterfire configure để đồng bộ cấu hình. Kiểm tra Google Services Gradle plugin
   đã được CLI thêm vào settings.gradle.kts và app/build.gradle.kts.
9. Dùng emulator có Google Play hoặc điện thoại thật có Google Play services.
   Với Chrome, thêm localhost vào Authentication → Settings → Authorized domains.
10. Dừng app hoàn toàn, chạy flutter pub get rồi chạy lại; thử đăng nhập, khởi động lại và đăng xuất.

Khi chưa cấu hình, app giải thích rõ trên màn hình. Không tự động dùng tài khoản/mật khẩu mô phỏng
để coi như Google Sign-In thành công. Bản Full vẫn dùng được đăng nhập API khi Google chưa cấu hình.

Tài liệu: https://firebase.google.com/docs/flutter/setup
Google Auth: https://firebase.google.com/docs/auth/flutter/federated-auth
Google Sign-In 7: https://pub.dev/packages/google_sign_in

