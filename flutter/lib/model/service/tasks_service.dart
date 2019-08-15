import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:rxdart/rxdart.dart';

import '../model.dart';

class TasksService {
  TasksService({@required this.authenticator});

  final Authenticator authenticator;
  TasksRef tasksRef;

  Stream<List<TaskDoc>> docs() {
    return Observable(authenticator.onAuthStateChanged
        .distinct((a, b) => a?.uid == b?.uid)).switchMap((firUser) {
      if (firUser == null) {
        return Observable.empty();
      }
      tasksRef = UsersRef.ref().docRef(firUser.uid).tasksRef;

      return tasksRef.documents((ref) => ref);
    });
  }

  void add(Task task) {
    tasksRef.docRef().set(task);
  }
}
