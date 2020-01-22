import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'due.g.dart';

@JsonSerializable()
@immutable
class Due {
  const Due(
    this.dateTime, {
    this.includeTime = false,
  });

  factory Due.fromJson(Map<String, dynamic> json) => _$DueFromJson(json);
  Map<String, dynamic> toJson() => _$DueToJson(this);

  @timestampJsonKey
  final DateTime dateTime;
  final bool includeTime;

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
