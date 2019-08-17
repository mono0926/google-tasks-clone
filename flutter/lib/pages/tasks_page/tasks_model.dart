import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/model.dart';
import 'package:google_tasks/util/util.dart';
import 'package:mono_kit/mono_kit.dart';

class TasksModel extends ChangeNotifier with SubscriptionHolderMixin {
  TasksModel({@required this.service}) {
    subscriptionHolder.add(
      service.docs().listen(
        (tasks) {
          _tasks = tasks;
          notifyListeners();
        },
        onError: logger.severe,
      ),
    );
  }
  final TasksService service;
  var _tasks = <TaskDoc>[];

  List<TaskDoc> get tasks => List<TaskDoc>.unmodifiable(_tasks);
}
