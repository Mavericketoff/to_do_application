import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:to_do_application/features/tasks/data/task_enums/significance.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final String id;
  final String text;
  final Significance significance;
  final bool isDone;
  final DateTime? deadline;

  Task({
    required this.text,
    String? id,
    this.significance = Significance.none,
    this.isDone = false,
    this.deadline,
  })  : id = id ?? const Uuid().v4(),
        super();

  @override
  List<Object?> get props => [id, text, significance, isDone, deadline];

  Task copyWith({
    String? id,
    String? text,
    Significance? significance,
    bool? isDone,
    DateTime? deadline,
    bool? deleteDeadline,
  }) {
    return Task(
      id: id ?? this.id,
      text: text ?? this.text,
      significance: significance ?? this.significance,
      isDone: isDone ?? this.isDone,
      deadline: deleteDeadline ?? false ? null : deadline ?? this.deadline,
    );
  }

  static Task fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
