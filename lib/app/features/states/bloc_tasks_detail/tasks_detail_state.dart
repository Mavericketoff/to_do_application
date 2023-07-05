part of 'tasks_detail_bloc.dart';

class TaskDetailsState extends Equatable {
  const TaskDetailsState({required this.currentTask, required this.isNewTask});

  final bool isNewTask;
  final Task currentTask;

  @override
  List<Object> get props => [currentTask];
}
