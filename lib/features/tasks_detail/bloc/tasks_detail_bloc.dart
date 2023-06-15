import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/features/tasks/data/task_enums/significance.dart';
import 'package:to_do_application/features/tasks/data/task_model.dart';

part 'tasks_detail_event.dart';
part 'tasks_detail_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  TaskDetailsBloc({required Task currentTask})
      : super(TaskDetailsState(currentTask: currentTask)) {
    on<TaskDetailsUpdateText>(_onTaskDetailsUpdateText);
    on<TaskDetailsUpdateSignificance>(_onTaskDetailsUpdateSignificance);
    on<TaskDetailsUpdateDeadline>(_onTaskDetailsUpdateDeadline);
    on<TaskDetailsDeleteDeadline>(_onTaskDetailsDeleteDeadline);
  }

  Future<void> _onTaskDetailsUpdateText(
      TaskDetailsUpdateText event, Emitter<TaskDetailsState> emit) async {
    emit(TaskDetailsState(
      currentTask: state.currentTask.copyWith(text: event.text),
    ));
  }

  Future<void> _onTaskDetailsUpdateSignificance(
      TaskDetailsUpdateSignificance event,
      Emitter<TaskDetailsState> emit) async {
    emit(TaskDetailsState(
      currentTask: state.currentTask.copyWith(significance: event.significance),
    ));
  }

  Future<void> _onTaskDetailsUpdateDeadline(
      TaskDetailsUpdateDeadline event, Emitter<TaskDetailsState> emit) async {
    emit(TaskDetailsState(
      currentTask: state.currentTask.copyWith(deadline: event.deadline),
    ));
  }

  Future<void> _onTaskDetailsDeleteDeadline(
      TaskDetailsDeleteDeadline event, Emitter<TaskDetailsState> emit) async {
    emit(TaskDetailsState(
        currentTask: state.currentTask.copyWith(deleteDeadline: true)));
  }
}
