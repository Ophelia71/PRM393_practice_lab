import 'package:flutter/material.dart';

// Widget nhỏ dùng chung cho trạng thái rỗng và lỗi của màn hình.
class RequestMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const RequestMessage({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, size: 40),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }
}

// Bỏ tiền tố của Exception để người dùng chỉ đọc thông báo dễ hiểu.
String readableError(Object? error) {
  return error.toString().replaceFirst(
    RegExp(r'^(Exception|FormatException): '),
    '',
  );
}
