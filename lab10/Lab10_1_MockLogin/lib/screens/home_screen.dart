import 'package:flutter/material.dart';

import '../models/app_user.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppUser user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.account_circle, size: 72),
              Text(
                'Xin chào ${user.name}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(user.email),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  // Xóa lịch sử để nút Back không quay lại Home.
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                      builder: (_) => const LoginScreen(),
                    ),
                    (_) => false,
                  );
                },
                child: const Text('Đăng xuất'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
