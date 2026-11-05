import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab9/models/local_item.dart';
import 'package:lab9/services/json_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory folder;
  late JsonStorage storage;
  setUp(() async {
    folder = await Directory.systemTemp.createTemp('lab9_test_');
    storage = JsonStorage('items.json', directory: folder);
  });
  tearDown(() async {
    await folder.delete(recursive: true);
  });

  test('Asset được đăng ký và có ít nhất hai trường hiển thị', () async {
    final text = await rootBundle.loadString('assets/data/products.json');
    final items = decodeItems(text);
    expect(items.length, 3);
    expect(items.first.name, 'Sổ tay');
    expect(items.first.note, isNotEmpty);
  });
  test('Lần đầu tạo file JSON rỗng', () async {
    expect(await storage.load(), isEmpty);
    expect(await (await storage.getFile()).readAsString(), '[]');
  });
  test('Thêm, sửa, xóa và đọc lại qua instance mới vẫn đúng', () async {
    await storage.save([const LocalItem(id: 1, name: 'Sổ tay', note: 'Mới')]);
    final reopened = JsonStorage('items.json', directory: folder);
    expect((await reopened.load()).single.name, 'Sổ tay');
    await reopened.save([
      const LocalItem(id: 1, name: 'Sổ đã sửa', note: 'Xong'),
    ]);
    expect((await storage.load()).single.name, 'Sổ đã sửa');
    await storage.save([]);
    expect(await reopened.load(), isEmpty);
  });
  test('JSON hỏng báo lỗi và không tự ghi đè file', () async {
    final file = await storage.getFile();
    await file.writeAsString('broken');
    await expectLater(storage.load(), throwsFormatException);
    expect(await file.readAsString(), 'broken');
  });
  test('Từ chối dữ liệu sai cấu trúc và ID trùng', () {
    expect(() => decodeItems('{}'), throwsFormatException);
    expect(() => decodeItems('[{"id":1}]'), throwsFormatException);
    expect(
      () => decodeItems(
        '[{"id":1,"name":"A","note":""},{"id":1,"name":"B","note":""}]',
      ),
      throwsFormatException,
    );
  });
}
