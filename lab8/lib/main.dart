import 'package:flutter/material.dart';

import 'screens/post_list_screen.dart';

// main() là điểm bắt đầu của ứng dụng Flutter.
void main() {
  runApp(const Lab8App());
}

class Lab8App extends StatelessWidget {
  const Lab8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 8 - Danh sách bài viết',
      home: Scaffold(
        appBar: AppBar(title: const Text('Danh sách bài viết')),
        body: const PostListScreen(),
      ),
    );
  }
}
