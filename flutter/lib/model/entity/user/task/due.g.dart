// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Due _$_$_DueFromJson(Map json) {
  return _$_Due(
    const TimestampConverter().fromJson(json['dateTime'] as Timestamp),
    includeTime: json['includeTime'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_DueToJson(_$_Due instance) => <String, dynamic>{
      'dateTime': const TimestampConverter().toJson(instance.dateTime),
      'includeTime': instance.includeTime,
    };
