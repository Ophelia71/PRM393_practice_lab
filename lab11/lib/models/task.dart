// Model bất biến: mỗi lần sửa/toggle sẽ tạo Task mới.
// Nhờ vậy Selector ở Lab 12 nhận ra đúng hàng nào thay đổi.
class Task {
  final int id;
  final String title;
  final bool completed;
  const Task({required this.id, required this.title, this.completed = false});

  Task toggle() => Task(id: id, title: title, completed: !completed);
  Task withTitle(String newTitle) =>
      Task(id: id, title: newTitle, completed: completed);
}
