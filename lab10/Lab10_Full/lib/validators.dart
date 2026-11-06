String? validateLogin(String? value) {
  if (value == null || value.trim().isEmpty) return 'Hãy nhập tên đăng nhập';
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Hãy nhập mật khẩu';
  return null;
}
