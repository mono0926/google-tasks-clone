import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/model.dart';

import 'due.dart';

export 'due.dart';
export 'task_doc.dart';
export 'tasks_ref.dart';

class Task extends Entity {
  const Task({
    @required this.title,
    this.details,
    this.due,
    DateTime createdAt,
    DateTime updatedAt,
  }) : super(
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  const Task.empty()
      : this(
          title: null,
        );

  Task.fromJson(Map<String, dynamic> json)
      : this(
          title: json[TaskField.title] as String,
          details: json[TaskField.details] as String,
          due: parse<Due>(json,
              key: TaskField.due, fromJson: (json) => Due.fromJson(json)),
          createdAt: parseCreatedAt(json),
          updatedAt: parseUpdatedAt(json),
        );

  Map<String, dynamic> toJson() => <String, dynamic>{
        TaskField.title: title,
        TaskField.details: details,
        TaskField.due: due?.toJson(),
        ...timestampJson,
      };

  final String title;
  final String details;
  final Due due;

  Task copyWith({
    String title,
    String details,
    Due due,
    bool clearDue = false,
  }) {
    return Task(
      title: title ?? this.title,
      details: details ?? this.details,
      due: clearDue ? null : due ?? this.due,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class TaskField {
  static const title = 'title';
  static const details = 'details';
  static const due = 'due';
}
