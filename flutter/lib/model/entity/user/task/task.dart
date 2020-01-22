import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'due.dart';

export 'due.dart';
export 'task_doc.dart';
export 'tasks_ref.dart';

part 'task.g.dart';

@JsonSerializable()
class Task with Entity, HasTimestamp {
  Task({
    @required this.title,
    this.details,
    this.due,
    this.createdAt,
    this.updatedAt,
  });

  Task.empty()
      : this(
          title: null,
        );

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        ..._$TaskToJson(this)..remove(TimestampField.createdAt),
        ...timestampJson,
      };

  final String title;
  final String details;
  final Due due;
  @override
  @timestampJsonKey
  final DateTime createdAt;
  @override
  @timestampJsonKey
  final DateTime updatedAt;

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
