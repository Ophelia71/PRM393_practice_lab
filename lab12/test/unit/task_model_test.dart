import 'package:flutter_test/flutter_test.dart';
import 'package:lab12/models/task.dart';

void main() {
  test('Mặc định completed là false', () {
    // Arrange: chuẩn bị dữ liệu.
    const task = Task(id: 1, title: 'Học Flutter');
    // Act: đọc trạng thái cần kiểm tra.
    final result = task.completed;
    // Assert: so sánh với kết quả mong muốn.
    expect(result, isFalse);
  });
  test('toggle chuyển false -> true -> false, không sửa model gốc', () {
    const original = Task(id: 1, title: 'Học Flutter'); // Arrange
    final completed = original.toggle(); // Act
    expect(completed.completed, isTrue); // Assert
    expect(completed.toggle().completed, isFalse);
    expect(original.completed, isFalse);
    expect(completed.id, original.id);
  });
}
