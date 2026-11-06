// Chỉ giữ thông tin cần cho giao diện và phiên, không lưu mật khẩu.
class AppUser {
  final String name;
  final String email;
  final String token;
  final DateTime expiresAt;
  final String source;
  const AppUser({
    required this.name,
    required this.email,
    required this.token,
    required this.expiresAt,
    this.source = 'api',
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'token': token,
    'expiresAt': expiresAt.toIso8601String(),
    'source': source,
  };

  factory AppUser.fromJson(Map<String, dynamic> json) {
    if (json['name'] is! String ||
        json['email'] is! String ||
        json['token'] is! String ||
        json['source'] is! String ||
        json['expiresAt'] is! String) {
      throw const FormatException('Phiên đăng nhập không đúng cấu trúc.');
    }
    final expiry = DateTime.tryParse(json['expiresAt'] as String);
    if (expiry == null) {
      throw const FormatException('Thời hạn phiên không hợp lệ.');
    }
    return AppUser(
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      expiresAt: expiry,
      source: json['source'] as String,
    );
  }
}
