import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_tasks/model/model.dart';

class Model extends ChangeNotifier {
  Model({
    @required this.service,
  });

  final TasksService service;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode detailsFocusNode = FocusNode();

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

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();

    super.dispose();
  }
}
