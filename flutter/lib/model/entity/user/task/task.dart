import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/firestore/firestore.dart';

import 'due.dart';

export 'due.dart';
export 'task_doc.dart';
export 'tasks_ref.dart';

class Task extends Entity {
  const Task({
    @required this.title,
    this.details,
    this.due,
  });

  const Task.empty()
      : this(
          title: null,
        );

  Task.fromJson(Map<String, dynamic> json)
      : this(
          title: json[TaskField.title] as String,
        );

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
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
      };
}

class TaskField {
  static const title = 'title';
}
