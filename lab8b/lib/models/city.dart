// API thời tiết nhận tọa độ, vì vậy mỗi thành phố cần vĩ độ và kinh độ.
class City {
  final String name;
  final double latitude;
  final double longitude;

  const City({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

// Danh sách cố định giúp người mới tập trung vào cách gọi API.
// Có thể thêm thành phố mới bằng cách thêm một City vào danh sách này.
const cities = [
  City(name: 'Hà Nội', latitude: 21.0285, longitude: 105.8542),
  City(name: 'Đà Nẵng', latitude: 16.0544, longitude: 108.2022),
  City(name: 'TP. Hồ Chí Minh', latitude: 10.8231, longitude: 106.6297),
];
