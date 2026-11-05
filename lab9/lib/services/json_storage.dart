import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/local_item.dart';

// Lưu trong thư mục riêng của ứng dụng, không cần xin quyền bộ nhớ ngoài.
class JsonStorage {
  final String fileName;
  final Directory? directory;

  // directory chỉ cần truyền khi test; lúc chạy dùng path_provider.
  JsonStorage(this.fileName, {this.directory});

  Future<File> getFile() async {
    final folder = directory ?? await getApplicationDocumentsDirectory();
    return File('${folder.path}/$fileName');
  }

  Future<List<LocalItem>> load() async {
    final file = await getFile();
    if (!await file.exists()) {
      await file.writeAsString('[]', flush: true);
    }
    // Không đổi file lỗi thành []: làm vậy có thể mất dữ liệu cũ khi lưu lại.
    return decodeItems(await file.readAsString());
  }

  Future<void> save(List<LocalItem> items) async {
    final file = await getFile();
    final data = items.map((item) => item.toJson()).toList();
    final text = const JsonEncoder.withIndent('  ').convert(data);
    // Ghi file tạm trước. Nếu ghi tạm lỗi, file chính vẫn còn nguyên.
    final tempFile = File('${file.path}.tmp');
    await tempFile.writeAsString(text, flush: true);
    await tempFile.rename(file.path);
  }
}

List<LocalItem> decodeItems(String text) {
  final data = jsonDecode(text);
  if (data is! List) throw const FormatException('JSON phải là một danh sách.');
  final items = <LocalItem>[];
  final ids = <int>{};
  for (final row in data) {
    if (row is! Map<String, dynamic>) {
      throw const FormatException('Mục JSON không hợp lệ.');
    }
    final item = LocalItem.fromJson(row);
    if (!ids.add(item.id)) {
      throw const FormatException('ID trong file bị trùng.');
    }
    items.add(item);
  }
  return items;
}
