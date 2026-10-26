import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/city.dart';
import '../models/weather.dart';

// Service là nơi duy nhất gửi HTTP. Màn hình chỉ cần gọi fetchWeather().
class ApiService {
  final http.Client _client;
  final Duration timeout;

  // Có thể truyền Client giả vào khi test; khi chạy thật sẽ tự tạo Client.
  ApiService({http.Client? client, this.timeout = const Duration(seconds: 15)})
    : _client = client ?? http.Client();

  // Future<Weather?> nghĩa là kết quả có sau, và có thể là null nếu API rỗng.
  Future<Weather?> fetchWeather(City city) async {
    final url = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': city.latitude.toString(),
      'longitude': city.longitude.toString(),
      'current':
          'temperature_2m,apparent_temperature,relative_humidity_2m,'
          'weather_code,wind_speed_10m',
      'temperature_unit': 'celsius',
      'wind_speed_unit': 'kmh',
      'timezone': 'Asia/Bangkok',
    });

    // await chờ API trả lời nhưng không khóa giao diện Flutter.
    final response = await _getJson(url);
    if (response is! Map<String, dynamic> || response['error'] == true) {
      throw const FormatException('API trả về dữ liệu không hợp lệ.');
    }

    final current = response['current'];
    if (current == null) return null;
    if (current is! Map<String, dynamic>) {
      throw const FormatException('Dữ liệu current không đúng định dạng.');
    }
    if (current.isEmpty) return null;

    // Model giúp UI đọc weather.temperature thay vì dùng Map động.
    return Weather.fromJson(current);
  }

  Future<dynamic> _getJson(Uri url) async {
    try {
      final response = await _client.get(url).timeout(timeout);
      if (response.statusCode != 200) {
        throw Exception(
          'Máy chủ trả về lỗi ${response.statusCode}. Hãy thử lại.',
        );
      }
      // bodyBytes được giải mã UTF-8 để hiển thị tiếng Việt đúng.
      return json.decode(utf8.decode(response.bodyBytes));
    } on TimeoutException {
      throw Exception('Kết nối quá lâu. Hãy kiểm tra mạng rồi thử lại.');
    } on http.ClientException {
      throw Exception(
        'Không thể kết nối API. Hãy kiểm tra Internet rồi thử lại.',
      );
    } on FormatException {
      throw const FormatException('Phản hồi của API không phải JSON hợp lệ.');
    }
  }

  void close() => _client.close();
}
