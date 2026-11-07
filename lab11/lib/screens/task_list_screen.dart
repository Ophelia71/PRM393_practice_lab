import 'package:flutter/material.dart';

import '../repositories/task_repository.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  final TaskRepository repository;
  const TaskListScreen({super.key, required this.repository});
  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _title = TextEditingController();
  String? _error;
  void _add() {
    if (_title.text.trim().isEmpty) {
      setState(() {
        _error = 'Hãy nhập tiêu đề.';
      });
      return;
    }
    setState(() {
      widget.repository.addTask(_title.text);
      _error = null;
      _title.clear();
    });
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = widget.repository.tasks;
    return Scaffold(
      appBar: AppBar(title: const Text('Taskly - Lab 11')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const ValueKey('addTaskField'),
                      controller: _title,
                      decoration: InputDecoration(
                        labelText: 'Tên tác vụ',
                        errorText: _error,
                      ),
                      onSubmitted: (_) => _add(),
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
              child: tasks.isEmpty
                  ? const Center(child: Text('No tasks yet. Add one!'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return ListTile(
                          key: ValueKey('task-${task.id}'),
                          leading: Checkbox(
                            value: task.completed,
                            onChanged: (_) => setState(() {
                              widget.repository.toggleTask(task.id);
                            }),
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          trailing: IconButton(
                            tooltip: 'Xóa',
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => setState(() {
                              widget.repository.deleteTask(task.id);
                            }),
                          ),
                          onTap: () async {
                            // await chờ trang Detail đóng, sau đó đọc lại repository để cập nhật list.
                            await Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => TaskDetailScreen(
                                  repository: widget.repository,
                                  taskId: task.id,
                                ),
                              ),
                            );
                            if (mounted) setState(() {});
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
