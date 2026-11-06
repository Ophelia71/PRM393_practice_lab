import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_user.dart';

// SharedPreferences dùng theo yêu cầu bài học. Không lưu mật khẩu vào đây.
class SessionStorage {
  static const _key = 'lab10_session';
  Future<void> save(AppUser user) async {
    final prefs = await SharedPreferences.getInstance();
    if (!await prefs.setString(_key, jsonEncode(user.toJson()))) {
      throw Exception('Không lưu được phiên đăng nhập.');
    }
  }

  Future<AppUser?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(_key);
    if (text == null) return null;
    try {
      final data = jsonDecode(text);
      if (data is! Map<String, dynamic>) throw const FormatException();
      final user = AppUser.fromJson(data);
      if (user.token.isEmpty || user.expiresAt.isBefore(DateTime.now())) {
        await clear();
        return null;
      }
      return user;
    } on FormatException {
      await clear();
      return null;
    }
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    if (!await prefs.remove(_key)) {
      throw Exception('Không xóa được phiên. Hãy thử lại.');
    }
  }
}
