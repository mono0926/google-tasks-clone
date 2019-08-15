import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_tasks/util/util.dart';

import '../model.dart';

class TasksService {
  TasksRef tasksRef;

  void updateFirebaseUser(FirebaseUser firUser) {
    logger.info(firUser);
    tasksRef =
        firUser == null ? null : UsersRef.ref().docRef(firUser.uid).tasksRef;
  }

  Stream<List<TaskDoc>> docs() {
    return tasksRef == null
        ? const Stream<List<TaskDoc>>.empty()
        : tasksRef.documents((ref) => ref);
  }

  void add(Task task) {
    if (tasksRef == null) {
      return;
    }
    tasksRef.docRef().set(task);
  }
}
