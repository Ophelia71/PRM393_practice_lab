import '../models/app_user.dart';

class AuthService {
  Future<AppUser> login(String email, String password) async {
    // Delay mô phỏng thời gian mạng; đây KHÔNG phải xác thực bằng backend thật.
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (email != 'student@example.com' || password != '123456') {
      throw Exception('Email hoặc mật khẩu không đúng.');
    }
    return AppUser(
      name: 'Sinh viên Flutter',
      email: email,
      token: 'mock-token-for-learning',
    );
  }
}
