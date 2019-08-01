import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/model.dart';

class TasksModel extends ChangeNotifier {
  final _tasks = <Task>[
    const Task(title: 'Hello'),
    const Task(title: 'Hello', details: 'World'),
    Task(
      title: 'Hello',
      details: 'World',
      due: Due(DateTime.now()),
    ),
  ];

  List<Task> get tasks => _tasks;

  void add(Task task) {
    _tasks.add(task);
  }
}
