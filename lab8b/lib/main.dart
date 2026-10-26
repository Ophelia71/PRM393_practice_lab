import 'package:flutter/material.dart';

import 'screens/weather_screen.dart';

// main() là điểm bắt đầu. runApp đưa widget gốc lên màn hình.
void main() {
  runApp(const Lab8BApp());
}

class Lab8BApp extends StatelessWidget {
  const Lab8BApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 8B - Weather Companion',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      // Scaffold tạo khung gồm thanh tiêu đề và phần nội dung chính.
      home: Scaffold(
        appBar: AppBar(title: const Text('Lab 8B · Thời tiết hữu ích')),
        body: const SafeArea(child: WeatherScreen()),
      ),
    );
  }
}
