import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';
import 'before_task_list_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});
  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _title = TextEditingController();
  final _error = ValueNotifier<String?>(null);
  bool _imageCached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Giải mã sẵn icon hay dùng, tránh chờ khi hiển thị lần tiếp theo.
    if (!_imageCached) {
      precacheImage(const AssetImage('assets/images/task_icon.png'), context);
      _imageCached = true;
    }
  }

  void _add() {
    if (_title.text.trim().isEmpty) {
      _error.value = 'Hãy nhập tiêu đề.';
      return;
    }
    // read chỉ lấy provider để gọi hàm; không đăng ký rebuild cả màn hình.
    context.read<TaskProvider>().addTask(_title.text);
    _title.clear();
    _error.value = null;
  }

  @override
  void dispose() {
    _title.dispose();
    _error.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Taskly - Lab 12'),
      actions: [
        IconButton(
          tooltip: 'Xem bản trước tối ưu',
          icon: const Icon(Icons.compare_arrows),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const BeforeTaskListScreen(),
            ),
          ),
        ),
      ],
    ),
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Ảnh gốc đã 128×128; dùng cùng AssetImage key với precacheImage.
                Image.asset(
                  'assets/images/task_icon.png',
                  width: 48,
                  height: 48,
                ),
                const SizedBox(width: 12),
                Selector<TaskProvider, int>(
                  selector: (_, p) => p.completedCount,
                  builder: (_, count, child) => Text('Đã hoàn thành: $count'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.read<TaskProvider>().addDemoTasks(),
                  child: const Text('+100 mẫu'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder<String?>(
                    valueListenable: _error,
                    builder: (_, error, child) => TextField(
                      key: const ValueKey('addTaskField'),
                      controller: _title,
                      decoration: InputDecoration(
                        labelText: 'Tên tác vụ',
                        errorText: error,
                      ),
                      onSubmitted: (_) => _add(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  key: const ValueKey('addTaskButton'),
                  onPressed: _add,
                  child: const Text('Thêm'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Selector<TaskProvider, List<Task>>(
              selector: (_, provider) => provider.tasks,
              // Khung list chỉ cần dựng lại khi thứ tự/số lượng ID thay đổi.
              // Tên/completed được Selector riêng trong TaskTile theo dõi.
              shouldRebuild: (previous, next) {
                if (previous.length != next.length) return true;
                for (var i = 0; i < previous.length; i++) {
                  if (previous[i].id != next[i].id) return true;
                }
                return false;
              },
              builder: (context, tasks, child) {
                if (tasks.isEmpty) {
                  return const Center(child: Text('No tasks yet. Add one!'));
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (_, index) => TaskTile(
                    key: ValueKey(tasks[index].id),
                    taskId: tasks[index].id,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
