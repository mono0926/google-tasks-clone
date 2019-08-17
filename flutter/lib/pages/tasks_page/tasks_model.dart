import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_tasks/l10n/l10n.dart';
import 'package:google_tasks/model/model.dart';
import 'package:google_tasks/util/util.dart';
import 'package:mono_kit/mono_kit.dart';

class TasksModel extends ChangeNotifier with SubscriptionHolderMixin {
  TasksModel({
    @required this.service,
    @required this.l10n,
  }) {
    subscriptionHolder
      ..add(
        service.docs().listen(
          (tasks) {
            _tasks = tasks;
            notifyListeners();
          },
          onError: logger.severe,
        ),
      )
      ..add(
        service.deleted.listen((doc) {
          _feedback.showUndo(
            text: l10n.taskDeleted,
            onUndo: () {
              service.add(doc.entity, id: doc.id);
            },
          );
        }),
      );
  }
  final TasksService service;
  final L10n l10n;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AppFeedback get _feedback => AppFeedback(scaffoldKey);
  var _tasks = <TaskDoc>[];

  List<TaskDoc> get tasks => List<TaskDoc>.unmodifiable(_tasks);
}
