import 'package:flutter/foundation.dart';

@immutable
class Due {
  const Due(
    this.dateTime, {
    this.includeTime = false,
  });
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
