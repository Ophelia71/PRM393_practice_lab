// Một model dùng cho cả ghi chú và mini database để bài học ngắn, dễ hiểu.
class LocalItem {
  final int id;
  final String name;
  final String note;

  const LocalItem({required this.id, required this.name, required this.note});

  factory LocalItem.fromJson(Map<String, dynamic> json) {
    if (json['id'] is! int ||
        json['name'] is! String ||
        json['note'] is! String) {
      throw const FormatException(
        'Một mục trong file JSON không đúng cấu trúc.',
      );
    }
    return LocalItem(
      id: json['id'] as int,
      name: json['name'] as String,
      note: json['note'] as String,
    );
  }

  // Chiều ngược lại với fromJson: model -> Map -> jsonEncode -> chuỗi JSON.
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'note': note};
  }
}
