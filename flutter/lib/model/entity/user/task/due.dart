import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'due.freezed.dart';
part 'due.g.dart';

@freezed
abstract class Due with _$Due {
  const factory Due(
    @TimestampConverter() DateTime dateTime, {
    @Default(false) bool includeTime,
  }) = _Due;

  factory Due.fromJson(Map<String, dynamic> json) => _$DueFromJson(json);
}

class DueField {
  static const dateTime = 'dateTime';
  static const includeTime = 'includeTime';
}
