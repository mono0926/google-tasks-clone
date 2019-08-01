import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/model.dart';

class InputModel extends ChangeNotifier {
  InputModel({@required this.holder});

  final TasksHolder holder;

  var _task = const Task.empty();
  var _isInputSheetShown = false;
  var _isDetailsShown = false;

  Task get task => _task;
  bool get isInputSheetShown => _isInputSheetShown;
  bool get isDetailsShown => _isDetailsShown;

  void toggleInputSheet({@required bool shown}) {
    _isInputSheetShown = shown;
    if (!shown) {
      _isDetailsShown = false;
      _task = const Task.empty();
    }
    notifyListeners();
  }

  void showDetails() {
    _isDetailsShown = true;
    notifyListeners();
  }

  set task(Task task) {
    _task = task;
    notifyListeners();
  }

  void save() {
    holder.add(task);
  }
}
