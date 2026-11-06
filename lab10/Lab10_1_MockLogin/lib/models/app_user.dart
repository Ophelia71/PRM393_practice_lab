// Dữ liệu nhận được sau khi đăng nhập. Không lưu mật khẩu.
class AppUser {
  final String name;
  final String email;
  final String token;

  const AppUser({required this.name, required this.email, required this.token});
}
