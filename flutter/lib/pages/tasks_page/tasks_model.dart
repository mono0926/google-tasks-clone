import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/model.dart';
import 'package:google_tasks/util/util.dart';

class TasksModel extends ChangeNotifier {
  TasksModel({@required this.observer}) {
    observer.docs().listen(
      (tasks) {
        _tasks = tasks;
        notifyListeners();
      },
      onError: logger.severe,
    );
  }
  final TasksService observer;
  var _tasks = <TaskDoc>[];

  List<TaskDoc> get tasks => List<TaskDoc>.unmodifiable(_tasks);

  void add(Task task) {
//    _tasks.add(task);
  }
}
