part of 'tasks_detail_bloc.dart';

abstract class TaskDetailsEvent extends Equatable {
  const TaskDetailsEvent();

  @override
  List<Object> get props => [];
}

class TaskDetailsUpdateText extends TaskDetailsEvent {
  final String text;

  const TaskDetailsUpdateText({required this.text});

  @override
  List<Object> get props => [text];
}

class TaskDetailsUpdateSignificance extends TaskDetailsEvent {
  final Significance significance;

  const TaskDetailsUpdateSignificance({required this.significance});

  @override
  List<Object> get props => [significance];
}

class TaskDetailsUpdateDeadline extends TaskDetailsEvent {
  final DateTime deadline;

  const TaskDetailsUpdateDeadline({required this.deadline});

  @override
  List<Object> get props => [deadline];
}

class TaskDetailsDeleteDeadline extends TaskDetailsEvent {
  const TaskDetailsDeleteDeadline();
}
