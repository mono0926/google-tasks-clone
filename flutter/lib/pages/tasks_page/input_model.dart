import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/model.dart';

class InputModel extends ChangeNotifier {
  InputModel({@required this.service});

  final TasksService service;

  var _task = const Task.empty();
  var _isDetailsShown = false;

  Task get task => _task;
  bool get isDetailsShown => _isDetailsShown;

  void showDetails() {
    _isDetailsShown = true;
    notifyListeners();
  }

  set task(Task task) {
    _task = task;
    notifyListeners();
  }

  void save() {
    service.add(task);
  }
}
