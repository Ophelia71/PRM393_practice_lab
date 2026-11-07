import '../models/task.dart';

// Repository là nơi tập trung thao tác dữ liệu; không biết gì về widget.
// Bài này dùng bộ nhớ để tập trung vào test, đóng ứng dụng thì dữ liệu mất.
class TaskRepository {
  final List<Task> _tasks = [];
  int _nextId = 1;

  // Không đưa List gốc ra ngoài để UI không tự ý thay đổi dữ liệu.
  List<Task> get tasks => List.unmodifiable(_tasks);

  Task? findById(int id) {
    for (final task in _tasks) {
      if (task.id == id) return task;
    }
    return null;
  }

  Task addTask(String title) {
    final cleaned = title.trim();
    if (cleaned.isEmpty) throw ArgumentError('Tiêu đề không được trống.');
    final task = Task(id: _nextId++, title: cleaned);
    _tasks.add(task);
    return task;
  }

  void updateTask(int id, String title) {
    final cleaned = title.trim();
    if (cleaned.isEmpty) throw ArgumentError('Tiêu đề không được trống.');
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) throw StateError('Không tìm thấy tác vụ.');
    _tasks[index] = _tasks[index].withTitle(cleaned);
  }

  void toggleTask(int id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) throw StateError('Không tìm thấy tác vụ.');
    _tasks[index] = _tasks[index].toggle();
  }

  void deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
  }
}
