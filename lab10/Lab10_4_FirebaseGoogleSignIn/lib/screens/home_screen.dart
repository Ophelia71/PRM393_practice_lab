import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../services/google_auth_service.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final AppUser user;
  const HomeScreen({super.key, required this.user});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  Future<void> _logout() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await GoogleAuthService().signOut();
      if (!mounted) return;
      // Xóa history để nút Back không quay về trang cần đăng nhập.
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
        (_) => false,
      );
    } catch (_) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Chưa đăng xuất được. Hãy thử lại.';
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
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.account_circle, size: 72),
            Text(
              'Xin chào ${widget.user.name}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(widget.user.email),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _isLoading ? null : _logout,
              child: const Text('Đăng xuất'),
            ),
            if (_errorMessage != null) Text(_errorMessage!),
          ],
        ),
      ),
    ),
  );
}
