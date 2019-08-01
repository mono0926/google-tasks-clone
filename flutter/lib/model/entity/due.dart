import 'package:flutter/foundation.dart';

@immutable
class Due {
  const Due(
    this.dateTime, {
    @required this.includeTime,
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
