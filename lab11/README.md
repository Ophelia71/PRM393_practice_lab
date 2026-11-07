# Lab 11 — Taskly Testing và Debugging

Mở lab11 trong Android Studio, chạy flutter pub get rồi Run trên Android hoặc Chrome.
UI hỗ trợ thêm, đánh dấu hoàn thành, xóa, mở chi tiết, sửa và lưu.
Dữ liệu chỉ ở RAM để tập trung vào test; khởi động lại app sẽ trở về danh sách rỗng.

## Đọc code

1. models/task.dart: model bất biến; toggle trả Task mới, giữ Task gốc.
2. repositories/task_repository.dart: quản lý dữ liệu, trim và kiểm tra tiêu đề.
3. screens/task_list_screen.dart: TextField + setState + ListView.builder.
4. screens/task_detail_screen.dart: Form, key detailTitleField và Navigator.pop.
5. test/unit rồi test/widget và test/integration: đọc Arrange → Act → Assert.

## Chạy test

- flutter test: unit, widget, navigation, full UI flow và tích hợp model/repository trong môi trường test.
- flutter test test/unit: chỉ logic thuần.
- flutter test test/widget: giao diện, điều hướng, flow thêm/sửa.
- flutter test integration_test -d <android-device-id>: integration test thật với Flutter engine trên thiết bị.

Theo đề, test/widget/task_integration_test.dart là một widget test mô phỏng full flow.
Thư mục integration_test ở gốc bổ sung bản test trên thiết bị thật; hai loại không được đánh đồng.
test/integration/repository_flow_test.dart kiểm tra các thành phần dữ liệu phối hợp.
Empty State và AppBar giữ tiếng Anh đúng chuỗi đề yêu cầu; comment/giải thích dùng tiếng Việt.

## DevTools và báo cáo

Xem reports/DEBUGGING_REPORT.md để thao tác Inspector/Performance và chụp ảnh thật.
Xem reports/TEST_SUMMARY.md sau khi chạy kiểm tra. Chưa có ảnh DevTools thì cần tự chụp khi nộp.
Đã có báo cáo PDF ở reports/LAB11_REPORT.pdf và bản Markdown để chỉnh sửa.
Luồng integration_test đã chạy thành công trên emulator Android; vẫn cần tự chụp hai ảnh DevTools để nộp.

