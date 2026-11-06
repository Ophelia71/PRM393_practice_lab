# Lab 10 - Học từng chức năng

Có 6 project độc lập. Thư mục lab10 chỉ chứa các bài; hãy mở từng project con trong Android Studio.

| Thứ tự | Project | Nội dung mới |
| --- | --- | --- |
| 1 | Lab10_1_MockLogin | Form, email/password, mock service, điều hướng |
| 2 | Lab10_2_RealApiLogin | POST API thật, JSON, access token, loading và lỗi |
| 3 | Lab10_3_AutoLogin_Logout | SharedPreferences, JSON lưu phiên, Splash, auto-login/logout |
| 4 | Lab10_4_FirebaseGoogleSignIn | Firebase quản lý phiên Google, hồ sơ và logout |
| 5 | Lab10_5_Notification | Thông báo hệ thống Android và quyền runtime |
| 6 | Lab10_Full | Tích hợp các chức năng, gửi notification sau login |

Mỗi bài có README chỉ thứ tự đọc code và tình huống kiểm tra.

- Mock: student@example.com / 123456.
- API: emilys / emilyspass.
- Google: cấu hình Firebase thật theo FIREBASE_SETUP.md ở bài 4 và Full.
- Notification: kiểm tra trên Android, ưu tiên API 33+ có Google Play.

Code chỉ thêm model lưu phiên từ bài 3; bài Google chỉ giữ dữ liệu hồ sơ. Bản Full phân biệt phiên API với phiên Firebase. Các project không import code qua thư mục bài khác.

Google Sign-In chưa thể hoạt động cho đến khi bạn gắn cấu hình Firebase riêng. Không giả lập Google login thành công.

Nộp 6 ZIP theo tên project, kèm README.

