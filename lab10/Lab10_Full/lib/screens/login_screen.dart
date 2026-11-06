import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../services/auth_service.dart';
import '../validators.dart';
import '../services/google_auth_service.dart';
import '../services/session_storage.dart';
import '../services/notification_service.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  final _notificationService = NotificationService();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _openHome(AppUser user) async {
    // Google tự quản lý phiên Firebase; chỉ lưu token của API vào preferences.
    if (user.source == 'api') {
      await SessionStorage().save(user);
    } else {
      await SessionStorage().clear();
    }
    String? notificationStatus;
    // Lỗi thông báo không được biến một lần login thành công thành lỗi login.
    try {
      notificationStatus = await _notificationService.showMessage(
        'Đăng nhập thành công. Xin chào ${user.name}!',
      );
    } catch (_) {
      notificationStatus = 'Đã đăng nhập, nhưng chưa gửi được thông báo.';
    }
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) =>
            HomeScreen(user: user, notificationStatus: notificationStatus),
      ),
    );
  }

  Future<void> _login() async {
    // Form chạy từng validator trước khi gọi service.
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final user = await _authService.login(
        _usernameController.text.trim(),
        _passwordController.text,
      );
      await _openHome(user);
    } catch (error) {
      if (mounted) {
        setState(() {
          _errorMessage = error.toString().replaceFirst('Exception: ', '');
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _authService.close();
    super.dispose();
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final user = await GoogleAuthService().signIn();
      await _openHome(user);
    } catch (_) {
      if (mounted) {
        setState(() {
          _errorMessage = GoogleAuthService.configurationError ?? 'Chưa đăng nhập Google. Nếu bạn đã hủy, hãy bấm lại khi sẵn sàng.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab10_Full')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.lock_outline, size: 56),
                  const SizedBox(height: 24),
                  TextFormField(
                    key: const ValueKey('loginField'),
                    controller: _usernameController,
                    enabled: !_isLoading,
                    decoration: const InputDecoration(
                      labelText: 'Tên đăng nhập',
                      border: OutlineInputBorder(),
                    ),
                    validator: validateLogin,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const ValueKey('passwordField'),
                    controller: _passwordController,
                    enabled: !_isLoading,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                    ),
                    validator: validatePassword,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _isLoading ? null : _login,
                    child: const Text('Đăng nhập'),
                  ),
                  const Text('Tài khoản mẫu: emilys / emilyspass'),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _isLoading ? null : _loginWithGoogle,
                    icon: const Icon(Icons.account_circle_outlined),
                    label: const Text('Đăng nhập Google'),
                  ),
                  if (!GoogleAuthService.isConfigured)
                    Text(
                      GoogleAuthService.configurationError ??
                          'Xem FIREBASE_SETUP.md để kết nối Firebase.',
                    ),
                  if (_isLoading)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
