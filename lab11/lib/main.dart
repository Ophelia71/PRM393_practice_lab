import 'package:flutter/material.dart';

import 'repositories/task_repository.dart';
import 'screens/task_list_screen.dart';

void main() => runApp(TasklyApp());

class TasklyApp extends StatelessWidget {
  final TaskRepository repository;
  TasklyApp({super.key, TaskRepository? repository})
    : repository = repository ?? TaskRepository();
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
    home: TaskListScreen(repository: repository),
  );
}
