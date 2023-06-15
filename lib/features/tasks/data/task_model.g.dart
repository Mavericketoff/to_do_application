// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      text: json['text'] as String,
      id: json['id'] as String?,
      significance:
          $enumDecodeNullable(_$SignificanceEnumMap, json['significance']) ??
              Significance.none,
      isDone: json['isDone'] as bool? ?? false,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'significance': _$SignificanceEnumMap[instance.significance]!,
      'isDone': instance.isDone,
      'deadline': instance.deadline?.toIso8601String(),
    };

const _$SignificanceEnumMap = {
  Significance.none: 'none',
  Significance.lowPriority: 'low',
  Significance.highPriority: 'high',
};
