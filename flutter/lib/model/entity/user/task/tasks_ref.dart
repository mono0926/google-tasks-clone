import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/entity/entity.dart';
import 'package:google_tasks/model/firestore/firestore.dart';

import 'task.dart';
import 'task_doc.dart';
import 'task_ref.dart';

export 'task_ref.dart';

class TasksRef extends CollectionRef<Task, TaskDoc> {
  const TasksRef._({
    @required CollectionReference ref,
    @required DocumentDecoder<TaskDoc> decoder,
    @required EntityEncoder<Task> encoder,
  }) : super(
          ref: ref,
          decoder: decoder,
          encoder: encoder,
        );

  factory TasksRef.ref(UserRef userRef) {
    return TasksRef._(
      ref: userRef.ref.collection(collection),
      decoder: _TaskDocDecoder(),
      encoder: _TaskEncoder(),
    );
  }

  static const collection = 'tasks';

  @override
  TaskRef docRef([String id]) {
    return TaskRef(
      ref: docRefRaw(id),
      encoder: encoder,
      decoder: decoder,
    );
  }
}

class _TaskDocDecoder extends DocumentDecoder<TaskDoc> {
  @override
  TaskDoc decode(DocumentSnapshot snapshot) {
    final data = snapshot.data;
    return TaskDoc(
      snapshot.documentID,
      Task.fromJson(data),
    );
  }
}

class _TaskEncoder extends EntityEncoder<Task> {
  @override
  Map<String, dynamic> encode(Task entity) {
    return entity.toJson();
  }
}
