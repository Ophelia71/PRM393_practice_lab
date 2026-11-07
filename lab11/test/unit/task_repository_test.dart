import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/repositories/task_repository.dart';

void main() {
  late TaskRepository repository;
  setUp(() {
    repository = TaskRepository();
  });

  test('addTask thêm và trim tiêu đề', () {
    const title = '  Học Dart  '; // Arrange
    final task = repository.addTask(title); // Act
    expect(repository.tasks.single.title, 'Học Dart'); // Assert
    expect(task.id, 1);
  });
  test('deleteTask xóa đúng ID', () {
    final first = repository.addTask('A');
    final second = repository.addTask('B');
    repository.deleteTask(first.id);
    expect(repository.tasks.single.id, second.id);
  });
  test('updateTask sửa đúng hàng và giữ completed', () {
    final task = repository.addTask('A');
    repository.toggleTask(task.id);
    repository.updateTask(task.id, 'Updated');
    expect(repository.tasks.single.title, 'Updated');
    expect(repository.tasks.single.completed, isTrue);
  });
  test('toggleTask đổi đúng trạng thái hai lần', () {
    final task = repository.addTask('A');
    repository.toggleTask(task.id);
    expect(repository.tasks.single.completed, isTrue);
    repository.toggleTask(task.id);
    expect(repository.tasks.single.completed, isFalse);
  });
  test('Xóa rồi thêm không trùng ID', () {
    final task = repository.addTask('A');
    repository.deleteTask(task.id);
    expect(repository.addTask('B').id, greaterThan(task.id));
  });
  test('Không thêm/sửa tiêu đề rỗng', () {
    expect(() => repository.addTask('  '), throwsArgumentError);
    final task = repository.addTask('A');
    expect(() => repository.updateTask(task.id, ''), throwsArgumentError);
    expect(repository.tasks.single.title, 'A');
  });
  test('ID không tồn tại và danh sách chỉ đọc', () {
    expect(() => repository.updateTask(99, 'A'), throwsStateError);
    expect(() => repository.toggleTask(99), throwsStateError);
    expect(() => repository.tasks.clear(), throwsUnsupportedError);
  });
}
