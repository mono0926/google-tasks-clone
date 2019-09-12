import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Due {
  const Due(
    this.dateTime, {
    this.includeTime = false,
  });

  Due.fromJson(Map<String, dynamic> json)
      : this(
          (json[DueField.dateTime] as Timestamp).toDate(),
          includeTime: json[DueField.includeTime] as bool,
        );

  final DateTime dateTime;
  final bool includeTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        DueField.dateTime: Timestamp.fromDate(dateTime),
        DueField.includeTime: includeTime,
      };

  Due copyWith(
    DateTime dateTime, {
    bool includeTime,
  }) {
    return Due(
      dateTime ?? this.dateTime,
      includeTime: includeTime ?? this.includeTime,
    );
  }
}

class DueField {
  static const dateTime = 'dateTime';
  static const includeTime = 'includeTime';
}
