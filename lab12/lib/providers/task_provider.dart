import 'package:flutter/foundation.dart';

import '../models/task.dart';
import '../repositories/task_repository.dart';

// Provider thông báo UI sau khi repository thay đổi dữ liệu.
class TaskProvider extends ChangeNotifier {
  final TaskRepository _repository;
  TaskProvider({TaskRepository? repository})
    : _repository = repository ?? TaskRepository();
  List<Task> get tasks => _repository.tasks;
  Task? findById(int id) => _repository.findById(id);
  int get completedCount => tasks.where((task) => task.completed).length;

  void addTask(String title) {
    _repository.addTask(title);
    notifyListeners();
  }

  void updateTask(int id, String title) {
    _repository.updateTask(id, title);
    notifyListeners();
  }

  void toggleTask(int id) {
    _repository.toggleTask(id);
    notifyListeners();
  }

  void deleteTask(int id) {
    _repository.deleteTask(id);
    notifyListeners();
  }

  void addDemoTasks() {
    for (var i = 1; i <= 100; i++) {
      _repository.addTask('Tác vụ mẫu $i');
    }
    // Thêm hàng loạt chỉ thông báo một lần, không thông báo 100 lần.
    notifyListeners();
  }
}
