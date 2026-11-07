import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/repositories/task_repository.dart';

void main() {
  test('Tích hợp model + repository: thêm -> sửa -> toggle -> xóa', () {
    final repository = TaskRepository(); // Arrange
    final task = repository.addTask('Original title'); // Act
    repository.updateTask(task.id, 'Updated title');
    repository.toggleTask(task.id);
    expect(repository.tasks.single.title, 'Updated title'); // Assert
    expect(repository.tasks.single.completed, isTrue);
    repository.deleteTask(task.id);
    expect(repository.tasks, isEmpty);
  });
}
