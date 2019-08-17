import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_tasks/util/util.dart';
import 'package:mono_kit/mono_kit.dart';

import '../model.dart';

class TasksService with SubscriptionHolderMixin {
  TasksRef tasksRef;
  final _deleted = StreamController<TaskDoc>.broadcast();

  void updateFirebaseUser(FirebaseUser firUser) {
    logger.info(firUser);
    tasksRef =
        firUser == null ? null : UsersRef.ref().docRef(firUser.uid).tasksRef;
  }

  Stream<List<TaskDoc>> docs() => tasksRef.documents((ref) => ref);
  Stream<TaskDoc> doc(String id) => tasksRef.docRef(id).document();
  Stream<TaskDoc> get deleted => _deleted.stream;

  void add(Task task, {String id}) {
    tasksRef.docRef(id).set(task);
  }

  void delete(TaskDoc doc) {
    tasksRef.docRef(doc.id).delete();
    _deleted.add(doc);
  }

  @override
  void dispose() {
    _deleted.close();

    super.dispose();
  }
}
