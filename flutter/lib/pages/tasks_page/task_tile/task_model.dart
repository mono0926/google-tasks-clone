import 'package:flutter/material.dart';
import 'package:google_tasks/model/entity/entity.dart';
import 'package:google_tasks/model/model.dart';
import 'package:mono_kit/mono_kit.dart';

class TaskModel extends ChangeNotifier with SubscriptionHolderMixin {
  TaskModel({
    @required this.doc,
    @required this.service,
  }) {
    subscriptionHolder.add(
      service.doc(doc.id).listen((doc) {
        final changed = this.doc?.entity != doc?.entity;
        this.doc = doc;
        if (changed) {
          notifyListeners();
        }
      }),
    );
  }

  TaskDoc doc;
  final TasksService service;

  void delete() {
    service.delete(doc);
  }
}
