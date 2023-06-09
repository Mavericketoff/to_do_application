import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:to_do_application/app/features/tasks/data/task_enums/significance.dart';

import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

extension TaskMapExtension on Map<String, dynamic> {
  Map<String, dynamic> toDBJson() {
    addEntries({'deleted': this['deleted'] ?? 0}.entries);
    return this;
  }
}

@JsonSerializable()
class Task extends Equatable {
  final String id;
  final String text;
  final Significance significance;
  @JsonKey(name: 'done')
  final bool isDone;
  @TimeStampOrNullConverter()
  final DateTime? deadline;
  final String? color;
  @TimeStampConverter()
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'changed_at')
  @TimeStampConverter()
  final DateTime changedAt;
  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;
  @JsonKey(includeToJson: false)
  final bool? deleted;

  Task(
      {required this.text,
      required this.createdAt,
      required this.changedAt,
      String? id,
      this.significance = Significance.none,
      this.isDone = false,
      this.deadline,
      this.color,
      this.lastUpdatedBy = 'example',
      this.deleted = false})
      : id = id ?? const Uuid().v4(),
        super();

  @override
  List<Object?> get props => [
        id,
        text,
        significance,
        isDone,
        deadline,
        color,
        createdAt,
        changedAt,
        lastUpdatedBy,
        deleted
      ];

  Task copyWith(
      {String? id,
      String? text,
      Significance? significance,
      bool? isDone,
      DateTime? deadline,
      bool? deleteDeadline,
      String? color,
      DateTime? createdAt,
      DateTime? changedAt,
      bool? deleted,
      String? lastUpdatedBy}) {
    return Task(
        id: id ?? this.id,
        text: text ?? this.text,
        significance: significance ?? this.significance,
        isDone: isDone ?? this.isDone,
        deadline: deleteDeadline ?? false ? null : deadline ?? this.deadline,
        color: color ?? this.color,
        createdAt: createdAt ?? this.createdAt,
        changedAt: changedAt ?? this.changedAt,
        deleted: deleted ?? this.deleted,
        lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy);
  }

  static Task fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  String toString() {
    return 'Task { id: $id, text: $text, importance: $significance, isDone: $isDone, deadline: $deadline, color: $color, createdAt: $createdAt, changedAt: $changedAt, lastUpdatedBy: $lastUpdatedBy }';
  }

  String toStringWithTypes() {
    return 'Task { id: $id ${id.runtimeType}, text: $text ${text.runtimeType}, importance: $significance ${significance.runtimeType}, isDone: $isDone ${isDone.runtimeType}, deadline: $deadline ${deadline.runtimeType}, color: $color ${color.runtimeType}, createdAt: $createdAt ${createdAt.runtimeType}, changedAt: $changedAt ${changedAt.runtimeType}, lastUpdatedBy: $lastUpdatedBy ${lastUpdatedBy.runtimeType}}';
  }
}

class TimeStampConverter implements JsonConverter<DateTime, int> {
  const TimeStampConverter();

  @override
  DateTime fromJson(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  @override
  int toJson(DateTime date) {
    return date.millisecondsSinceEpoch;
  }
}

class TimeStampOrNullConverter implements JsonConverter<DateTime?, int?> {
  const TimeStampOrNullConverter();

  @override
  DateTime? fromJson(int? timestamp) {
    return timestamp == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  @override
  int? toJson(DateTime? date) {
    return date?.millisecondsSinceEpoch;
  }
}
