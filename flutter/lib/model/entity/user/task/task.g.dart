// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$_$_TaskFromJson(Map json) {
  return _$_Task(
    title: json['title'] as String ?? '',
    details: json['details'] as String,
    due: json['due'] == null
        ? null
        : Due.fromJson((json['due'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    createdAt:
        const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    updatedAt:
        const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
  );
}

Map<String, dynamic> _$_$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'title': instance.title,
      'details': instance.details,
      'due': instance.due?.toJson(),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
