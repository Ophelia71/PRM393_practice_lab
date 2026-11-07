import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

// Bản đối chiếu trước tối ưu: cố ý watch ở cả màn hình và để inline ListTile.
// Mở bằng nút so sánh trên AppBar để quan sát rebuild trong DevTools.
class BeforeTaskListScreen extends StatelessWidget {
  const BeforeTaskListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final tasks = provider.tasks;
    return Scaffold(
      appBar: AppBar(title: const Text('Trước tối ưu - đối chiếu')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            leading: Checkbox(
              value: task.completed,
              onChanged: (_) => provider.toggleTask(task.id),
            ),
          );
        },
      ),
    );
  }
}
