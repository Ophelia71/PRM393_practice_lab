import 'package:flutter/material.dart';

import '../models/city.dart';
import '../models/weather.dart';
import '../services/api_service.dart';
import '../widgets/request_message.dart';

class WeatherScreen extends StatefulWidget {
  final ApiService? apiService;

  const WeatherScreen({super.key, this.apiService});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final ApiService _apiService;
  City _selectedCity = cities.first;
  late Future<Weather?> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _apiService = widget.apiService ?? ApiService();
    _weatherFuture = _apiService.fetchWeather(_selectedCity);
  }

  void _reload() {
    setState(() {
      _weatherFuture = _apiService.fetchWeather(_selectedCity);
    });
  }

  void _changeCity(City? city) {
    if (city == null) return;
    setState(() {
      _selectedCity = city;
      // Thành phố đổi -> Future đổi -> FutureBuilder hiển thị dữ liệu mới.
      _weatherFuture = _apiService.fetchWeather(city);
    });
  }

  @override
  void dispose() {
    if (widget.apiService == null) _apiService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButton<City>(
                  value: _selectedCity,
                  isExpanded: true,
                  // map chuyển mỗi City thành một lựa chọn trong dropdown.
                  items: cities.map((city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city.name),
                    );
                  }).toList(),
                  onChanged: _changeCity,
                ),
              ),
              IconButton(
                tooltip: 'Tải lại thời tiết',
                onPressed: _reload,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<Weather?>(
            future: _weatherFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return RequestMessage(
                  message: readableError(snapshot.error),
                  onRetry: _reload,
                );
              }

              final weather = snapshot.data;
              if (weather == null) {
                return RequestMessage(
                  message: 'Chưa có dữ liệu thời tiết cho thành phố này.',
                  onRetry: _reload,
                );
              }

              // ListView giúp nội dung cuộn được trên điện thoại màn hình nhỏ.
              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Icon(Icons.cloud_outlined, size: 48),
                          const SizedBox(height: 12),
                          Text(
                            '${weather.temperature.toStringAsFixed(1)} °C',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(weather.description),
                          const SizedBox(height: 16),
                          Text(
                            'Cảm giác như: ${weather.feelsLike.toStringAsFixed(1)} °C',
                          ),
                          Text('Độ ẩm: ${weather.humidity}%'),
                          Text(
                            'Gió: ${weather.windSpeed.toStringAsFixed(1)} km/h',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.lightbulb_outline),
                      title: const Text('Gợi ý lúc này'),
                      subtitle: Text(weather.advice),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Thời điểm dữ liệu: ${weather.time.replaceFirst('T', ' ')} (UTC+7)',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nguồn: Open-Meteo · CC BY 4.0\nhttps://open-meteo.com/',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Gợi ý dựa trên thời tiết hiện tại, không phải dự báo cho cả ngày.',
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
