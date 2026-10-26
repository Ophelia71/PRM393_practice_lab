import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lab8b/screens/weather_screen.dart';
import 'package:lab8b/services/api_service.dart';

void main() {
  testWidgets('Lỗi → Thử lại → chọn thành phố → xem gợi ý', (tester) async {
    var calls = 0;
    final service = ApiService(
      client: MockClient((request) async {
        calls++;
        if (calls == 1) return http.Response('error', 503);
        if (calls == 2) return http.Response('{"current":null}', 200);
        expect(request.url.queryParameters['latitude'], '16.0544');
        return http.Response(
          jsonEncode({
            'current': {
              'temperature_2m': 29.5,
              'apparent_temperature': 31,
              'relative_humidity_2m': 70,
              'wind_speed_10m': 12,
              'weather_code': 61,
              'time': '2026-10-15T12:00',
            },
          }),
          200,
        );
      }),
    );
    addTearDown(service.close);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: WeatherScreen(apiService: service)),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('503'), findsOneWidget);
    await tester.tap(find.text('Thử lại'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Chưa có dữ liệu thời tiết'), findsOneWidget);

    await tester.tap(find.text('Hà Nội'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Đà Nẵng').last);
    await tester.pumpAndSettle();
    expect(find.text('29.5 °C'), findsOneWidget);
    expect(find.textContaining('áo mưa'), findsOneWidget);
    expect(calls, 3);
  });
}
