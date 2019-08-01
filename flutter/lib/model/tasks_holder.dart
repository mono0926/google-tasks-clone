import 'package:rxdart/rxdart.dart';

import 'model.dart';

class TasksHolder {
  final _tasks = BehaviorSubject<List<Task>>.seeded([
    const Task(title: 'Hello'),
    const Task(title: 'Hello', details: 'World'),
    Task(
      title: 'Hello',
      details: 'World',
      due: Due(DateTime.now()),
    ),
  ]);

  Stream<List<Task>> get tasks => _tasks;

  void add(Task task) {
    _tasks.add(_tasks.value + [task]);
  }

  void dispose() {
    _tasks.close();
  }
}
