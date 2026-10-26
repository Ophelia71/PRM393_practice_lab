class Weather {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int weatherCode;
  final String time;

  const Weather({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.time,
  });

  // Hàm này nhận phần "current" bên trong JSON của Open-Meteo.
  factory Weather.fromJson(Map<String, dynamic> json) {
    if (json['temperature_2m'] is! num ||
        json['apparent_temperature'] is! num ||
        json['relative_humidity_2m'] is! int ||
        json['wind_speed_10m'] is! num ||
        json['weather_code'] is! int ||
        json['time'] is! String ||
        DateTime.tryParse(json['time'] as String) == null) {
      throw const FormatException('Dữ liệu thời tiết không đúng định dạng.');
    }

    return Weather(
      // num nhận cả int lẫn double. toDouble() chuyển về kiểu UI cần dùng.
      temperature: (json['temperature_2m'] as num).toDouble(),
      feelsLike: (json['apparent_temperature'] as num).toDouble(),
      humidity: json['relative_humidity_2m'] as int,
      windSpeed: (json['wind_speed_10m'] as num).toDouble(),
      weatherCode: json['weather_code'] as int,
      time: json['time'] as String,
    );
  }

  // Getter được đọc như thuộc tính: weather.isRainy, không cần dấu ().
  bool get isRainy {
    return [
      51,
      53,
      55,
      56,
      57,
      61,
      63,
      65,
      66,
      67,
      80,
      81,
      82,
    ].contains(weatherCode);
  }

  bool get isSnowy => [71, 73, 75, 77, 85, 86].contains(weatherCode);
  bool get isStormy => [95, 96, 99].contains(weatherCode);

  // Mã thời tiết WMO được Open-Meteo công bố trong tài liệu API.
  String get description {
    if (weatherCode == 0) return 'Trời quang';
    if ([1, 2, 3].contains(weatherCode)) return 'Có mây';
    if ([45, 48].contains(weatherCode)) return 'Sương mù';
    if (isStormy) return 'Dông';
    if (isRainy) return 'Có mưa';
    if (isSnowy) return 'Có tuyết';
    return 'Chưa có mô tả cho mã $weatherCode';
  }

  // Đây là quy tắc minh họa do ứng dụng tự đặt, không phải dự báo cả ngày.
  String get advice {
    if (isStormy) return 'Đang có dông, hãy hạn chế hoạt động ngoài trời.';
    if (isRainy) return 'Đang có mưa, hãy mang ô hoặc áo mưa khi ra ngoài.';
    if (isSnowy) return 'Có tuyết, hãy mặc ấm và chú ý đường trơn.';
    if ([45, 48].contains(weatherCode)) {
      return 'Có sương mù, hãy chú ý tầm nhìn khi đi đường.';
    }
    if (temperature >= 35) return 'Trời nóng, hãy mang nước và tránh nắng gắt.';
    if (temperature < 20) {
      return 'Trời mát hoặc lạnh, bạn có thể mang áo khoác.';
    }
    if ([0, 1, 2, 3].contains(weatherCode)) {
      return 'Có thể cân nhắc đi dạo, hãy kiểm tra thời tiết trước khi đi.';
    }
    return 'Chưa đủ thông tin để đưa ra gợi ý hoạt động.';
  }
}
