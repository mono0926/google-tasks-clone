import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_tasks/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'due.dart';

export 'due.dart';
export 'task_doc.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    @Default('') String title,
    String details,
    Due due,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

class TaskField {
  static const title = 'title';
  static const details = 'details';
  static const due = 'due';
}

class TaskRef extends DocumentRef<Task, TaskDoc> {
  TaskRef({
    @required String id,
    @required TasksRef collectionRef,
  }) : super(
          id: id,
          collectionRef: collectionRef,
        );
}

class TasksRef extends CollectionRef<Task, TaskDoc> {
  TasksRef._({
    @required CollectionReference ref,
  }) : super(
          ref,
          decoder: (snapshot) => TaskDoc(
            snapshot.documentID,
            Task.fromJson(snapshot.data),
          ),
          encoder: (task) => replacingTimestamp(
            json: task.toJson(),
            createdAt: task.createdAt,
          ),
        );

  factory TasksRef.ref(UserRef userRef) {
    return TasksRef._(
      ref: userRef.ref.collection(collection),
    );
  }

  static const collection = 'tasks';

  @override
  TaskRef docRef([String id]) {
    return TaskRef(
      id: id,
      collectionRef: this,
    );
  }
}
