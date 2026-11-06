import 'package:flutter/material.dart';

import '../services/google_auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _errorMessage;
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    setState(() {
      _errorMessage = null;
    });
    try {
      final user = await GoogleAuthService().restore();
      if (!mounted) return;
      final restored = user;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => restored == null
              ? const LoginScreen()
              : HomeScreen(user: restored),
        ),
      );
    } catch (_) {
      if (mounted) {
        setState(() {
          _errorMessage =
              'Chưa kiểm tra được phiên. Kiểm tra Internet rồi thử lại.';
        });
      }
    }
  }

  Future<void> _clearSessionAndLogin() async {
    try {
      await GoogleAuthService().signOut();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      );
    } catch (_) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Chưa xóa được phiên. Hãy thử lại.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: _errorMessage == null
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_errorMessage!),
                  FilledButton(
                    onPressed: _checkSession,
                    child: const Text('Thử lại'),
                  ),
                  TextButton(
                    onPressed: _clearSessionAndLogin,
                    child: const Text('Đăng nhập lại'),
                  ),
                ],
              ),
            ),
    ),
  );
}
