import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/task_detail_screen.dart';

class TaskTile extends StatelessWidget {
  final int taskId;
  const TaskTile({super.key, required this.taskId});
  @override
  Widget build(BuildContext context) {
    // Mỗi hàng chỉ chọn đúng Task của mình. Task khác thay đổi không dựng lại ListTile này.
    return Selector<TaskProvider, Task?>(
      selector: (_, provider) => provider.findById(taskId),
      builder: (context, task, child) {
        if (task == null) return const SizedBox.shrink();
        final provider = context.read<TaskProvider>();
        return ListTile(
          leading: Checkbox(
            value: task.completed,
            onChanged: (_) => provider.toggleTask(task.id),
          ),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.completed ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: IconButton(
            tooltip: 'Xóa',
            icon: const Icon(Icons.delete_outline),
            onPressed: () => provider.deleteTask(task.id),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => TaskDetailScreen(taskId: task.id),
            ),
          ),
        );
      },
    );
  }
}
