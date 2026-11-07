import 'package:flutter_test/flutter_test.dart';
import 'package:lab12/providers/task_provider.dart';

void main() {
  test(
    'Chỉ Task thay đổi được tạo model mới; hàng còn lại giữ cùng đối tượng',
    () {
      final provider = TaskProvider();
      addTearDown(provider.dispose);
      provider.addTask('A');
      provider.addTask('B');
      final before = provider.tasks;
      provider.toggleTask(before.first.id);
      expect(identical(before.first, provider.tasks.first), isFalse);
      expect(identical(before.last, provider.tasks.last), isTrue);
      expect(provider.completedCount, 1);
    },
  );
  test('Thêm 100 mẫu chỉ phát một thông báo thay đổi', () {
    final provider = TaskProvider();
    addTearDown(provider.dispose);
    var notifications = 0;
    provider.addListener(() {
      notifications++;
    });
    provider.addDemoTasks();
    expect(provider.tasks.length, 100);
    expect(notifications, 1);
  });
}
