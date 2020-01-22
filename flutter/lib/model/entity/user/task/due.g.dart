// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Due _$DueFromJson(Map json) {
  return Due(
    dateFromTimestampValue(json['dateTime']),
    includeTime: json['includeTime'] as bool,
  );
}

Map<String, dynamic> _$DueToJson(Due instance) => <String, dynamic>{
      'dateTime': timestampFromDateValue(instance.dateTime),
      'includeTime': instance.includeTime,
    };
