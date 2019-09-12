import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_tasks/util/util.dart';
import 'package:mono_kit/mono_kit.dart';

import '../model.dart';

class TasksService with SubscriptionHolderMixin {
  TasksService({@required this.authenticator}) {
    _tasksRef = authenticator.userRef.value.tasksRef;
    subscriptionHolder.add(
      authenticator.userRef.listen((userRef) {
        _tasksRef = userRef.tasksRef;
      }),
    );
  }

  TasksRef _tasksRef;
  final _deleted = StreamController<TaskDoc>.broadcast();
  final Authenticator authenticator;

  void updateFirebaseUser(FirebaseUser firUser) {
    logger.info(firUser);
    _tasksRef =
        firUser == null ? null : UsersRef.ref().docRef(firUser.uid).tasksRef;
  }

  Stream<List<TaskDoc>> docs() => _tasksRef.documents((ref) => ref);
  Stream<TaskDoc> doc(String id) => _tasksRef.docRef(id).document();
  Stream<TaskDoc> get deleted => _deleted.stream;

  void add(Task task, {String id}) {
    _tasksRef.docRef(id).set(task);
  }

  void delete(TaskDoc doc) {
    _tasksRef.docRef(doc.id).delete();
    _deleted.add(doc);
  }

  @override
  void dispose() {
    _deleted.close();

    super.dispose();
  }
}
