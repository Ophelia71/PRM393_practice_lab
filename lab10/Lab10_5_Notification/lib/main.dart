import 'package:flutter/material.dart';

import 'services/notification_service.dart';

void main() => runApp(const NotificationApp());

class NotificationApp extends StatelessWidget {
  const NotificationApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
    home: const NotificationScreen(),
  );
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _notificationService = NotificationService();
  String _statusMessage = 'Bấm nút, cấp quyền rồi mở thanh thông báo Android.';
  bool _isLoading = false;

  Future<void> _showNotification() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await _notificationService.showMessage(
        'Bạn vừa hoàn thành bài Local Notification!',
      );
      if (mounted) {
        setState(() {
          _statusMessage = result;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _statusMessage =
              'Không gửi được thông báo. Kiểm tra quyền và cấu hình Android.';
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
    appBar: AppBar(title: const Text('Lab 10.5 - Notification')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_statusMessage, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _isLoading ? null : _showNotification,
              icon: const Icon(Icons.notifications_outlined),
              label: Text(_isLoading ? 'Đang gửi...' : 'Hiện thông báo'),
            ),
          ],
        ),
      ),
    ),
  );
}
