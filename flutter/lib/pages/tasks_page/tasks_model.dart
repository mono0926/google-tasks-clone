import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/model.dart';

class TasksModel extends ChangeNotifier {
  TasksModel({@required this.holder}) {
    holder.tasks.listen((tasks) {
      // とりあえず後に追加されたものから先頭に
      _tasks = tasks.reversed.toList();
      notifyListeners();
    });
  }
  final TasksHolder holder;
  var _tasks = <Task>[];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void add(Task task) {
    _tasks.add(task);
  }
}
