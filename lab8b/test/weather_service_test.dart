import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lab8b/models/city.dart';
import 'package:lab8b/models/weather.dart';
import 'package:lab8b/services/api_service.dart';

// MockClient trả dữ liệu giả, nên test không phụ thuộc mạng Internet.
void main() {
  test('GET đúng tọa độ và chuyển JSON thành Weather', () async {
    final service = ApiService(
      client: MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.host, 'api.open-meteo.com');
        expect(
          request.url.queryParameters['latitude'],
          cities.first.latitude.toString(),
        );
        return http.Response(
          jsonEncode({
            'current': {
              'temperature_2m': 31,
              'apparent_temperature': 34,
              'relative_humidity_2m': 75,
              'wind_speed_10m': 10,
              'weather_code': 61,
              'time': '2026-10-15T12:00',
            },
          }),
          200,
        );
      }),
    );
    addTearDown(service.close);

    final weather = await service.fetchWeather(cities.first);
    expect(weather?.temperature, 31);
    expect(weather?.isRainy, isTrue);
    expect(weather?.advice, contains('áo mưa'));
  });

  test('API rỗng trả null để UI hiện thông báo', () async {
    final service = ApiService(
      client: MockClient((_) async => http.Response('{"current":null}', 200)),
    );
    addTearDown(service.close);
    expect(await service.fetchWeather(cities.first), isNull);
  });

  test('Lỗi HTTP và JSON sai được báo rõ', () async {
    final serverError = ApiService(
      client: MockClient((_) async => http.Response('error', 503)),
    );
    final badJson = ApiService(
      client: MockClient((_) async => http.Response('{"current":[]}', 200)),
    );
    addTearDown(serverError.close);
    addTearDown(badJson.close);
    await expectLater(
      serverError.fetchWeather(cities.first),
      throwsA(predicate((Object e) => e.toString().contains('503'))),
    );
    await expectLater(
      badJson.fetchWeather(cities.first),
      throwsA(isA<FormatException>()),
    );
  });

  test('Mất mạng và timeout có thông báo dễ hiểu', () async {
    final offline = ApiService(
      client: MockClient((_) async {
        throw http.ClientException('offline');
      }),
    );
    final pending = Completer<http.Response>();
    final slow = ApiService(
      client: MockClient((_) => pending.future),
      timeout: const Duration(milliseconds: 5),
    );
    addTearDown(offline.close);
    addTearDown(slow.close);
    await expectLater(
      offline.fetchWeather(cities.first),
      throwsA(predicate((Object e) => e.toString().contains('Internet'))),
    );
    await expectLater(
      slow.fetchWeather(cities.first),
      throwsA(predicate((Object e) => e.toString().contains('quá lâu'))),
    );
    pending.complete(http.Response('{}', 200));
  });

  test('Gợi ý ưu tiên dông và tránh lời khuyên sai cho mã lạ', () {
    Weather sample(int code) => Weather(
      temperature: 25,
      feelsLike: 25,
      humidity: 70,
      windSpeed: 10,
      weatherCode: code,
      time: '2026-10-15T12:00',
    );
    expect(sample(95).advice, contains('dông'));
    expect(sample(999).advice, contains('Chưa đủ thông tin'));
  });
}
