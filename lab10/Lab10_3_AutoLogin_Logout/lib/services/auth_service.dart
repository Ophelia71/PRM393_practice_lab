import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/app_user.dart';

class AuthService {
  final http.Client _client;
  AuthService({http.Client? client}) : _client = client ?? http.Client();

  Future<AppUser> login(String username, String password) async {
    try {
      final response = await _client
          .post(
            Uri.https('dummyjson.com', '/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': username,
              'password': password,
              'expiresInMins': 30,
            }),
          )
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 400 || response.statusCode == 401) {
        throw Exception('Tên đăng nhập hoặc mật khẩu không đúng.');
      }
      if (response.statusCode != 200) {
        throw Exception('Máy chủ gặp lỗi. Hãy thử lại.');
      }
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data is! Map<String, dynamic> ||
          data['accessToken'] is! String ||
          (data['accessToken'] as String).isEmpty ||
          data['username'] is! String ||
          data['email'] is! String) {
        throw const FormatException('Phản hồi đăng nhập không hợp lệ.');
      }
      return AppUser(
        name: data['username'] as String,
        email: data['email'] as String,
        token: data['accessToken'] as String,
        expiresAt: DateTime.now().add(const Duration(minutes: 30)),
      );
    } on TimeoutException {
      throw Exception('Kết nối quá lâu. Hãy thử lại.');
    } on http.ClientException {
      throw Exception('Không kết nối được API. Kiểm tra Internet.');
    } on FormatException {
      throw const FormatException('API trả về dữ liệu không hợp lệ.');
    }
  }

  Future<bool> validateSession(AppUser user) async {
    if (user.token.isEmpty || user.expiresAt.isBefore(DateTime.now())) {
      return false;
    }
    try {
      final response = await _client
          .get(
            Uri.https('dummyjson.com', '/auth/me'),
            headers: {'Authorization': 'Bearer ${user.token}'},
          )
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 401 || response.statusCode == 403) {
        return false;
      }
      if (response.statusCode != 200) {
        throw Exception('Chưa kiểm tra được phiên. Hãy thử lại.');
      }
      return true;
    } on TimeoutException {
      throw Exception('Kiểm tra phiên quá lâu. Hãy thử lại.');
    } on http.ClientException {
      throw Exception('Cần Internet để kiểm tra phiên.');
    }
  }

  void close() => _client.close();
}
