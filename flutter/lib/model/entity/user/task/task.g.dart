// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map json) {
  return Task(
    title: json['title'] as String,
    details: json['details'] as String,
    due: json['due'] == null
        ? null
        : Due.fromJson((json['due'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    createdAt: dateFromTimestampValue(json['createdAt']),
    updatedAt: dateFromTimestampValue(json['updatedAt']),
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'details': instance.details,
      'due': instance.due?.toJson(),
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
    };
