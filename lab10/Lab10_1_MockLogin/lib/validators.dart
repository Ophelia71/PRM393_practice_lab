String? validateLogin(String? value) {
  if (value == null || value.trim().isEmpty) return 'Hãy nhập email';
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
    return 'Email chưa đúng định dạng';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Hãy nhập mật khẩu';
  if (value.length < 6) return 'Mật khẩu cần ít nhất 6 ký tự';
  return null;
}
