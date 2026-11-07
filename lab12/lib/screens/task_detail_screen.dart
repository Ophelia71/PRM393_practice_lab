import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class TaskDetailScreen extends StatefulWidget {
  final int taskId;

  const TaskDetailScreen({super.key, required this.taskId});
  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  @override
  void initState() {
    super.initState();
    final task = context.read<TaskProvider>().findById(widget.taskId);
    _title = TextEditingController(text: task?.title ?? '');
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<TaskProvider>().updateTask(widget.taskId, _title.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Task Detail')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Key cố định giúp test tìm đúng ô nhập, không phụ thuộc nội dung hiển thị.
            TextFormField(
              key: const ValueKey('detailTitleField'),
              controller: _title,
              decoration: const InputDecoration(labelText: 'Tiêu đề'),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Hãy nhập tiêu đề.'
                  : null,
            ),
            const SizedBox(height: 16),
            FilledButton(
              key: const ValueKey('saveTaskButton'),
              onPressed: _save,
              child: const Text('Lưu'),
            ),
          ],
        ),
      ),
    ),
  );
}
