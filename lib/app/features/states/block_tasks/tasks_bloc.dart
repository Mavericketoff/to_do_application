import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/core/common/logger.dart';
import 'package:to_do_application/app/core/utils/persistence_util.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';
import 'package:to_do_application/app/features/tasks/utils/repository/repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc(
      {required Repository repository,
      required PersistenceUtil persistenceUtil})
      : _repository = repository,
        _persistenceUtil = persistenceUtil,
        super(const TasksState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<ToggleVisibilityCompletedFilter>(_onToggleVisibilityCompletedFilter);
  }

  final Repository _repository;
  final PersistenceUtil _persistenceUtil;

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) async {
    emit(state.copyWith(status: TasksStatus.loading));
    try {
      final tasks = (await _repository.getTasks())
          .where((task) => !(task.deleted ?? false))
          .toList();
      emit(state.copyWith(tasks: tasks, status: TasksStatus.success));
      logger.info('Load tasks: ${tasks.length}');
    } on Exception catch (e) {
      emit(state.copyWith(status: TasksStatus.failure));
      logger.severe('Load tasks: $e');
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    final deviceId = await _persistenceUtil.getDeviceId();
    final task = event.task.copyWith(lastUpdatedBy: deviceId);
    final updatedTasks = [...state.tasks, task];
    emit(state.copyWith(tasks: updatedTasks));
    logger.info('AddTask in temp array');
    try {
      await _repository.addTask(task);
      logger.info('AddTask to storages: $task');
    } on Exception catch (e) {
      logger.severe('AddTask: $e');
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    final updatedTasks = [
      for (final t in state.tasks)
        if (t.id == event.task.id) event.task else t
    ];
    emit(state.copyWith(tasks: updatedTasks));
    logger.info('Update task in temp array');
    try {
      await _repository.updateTask(event.task);
      logger.info('Update task in storages: ${event.task}');
    } on Exception catch (e) {
      logger.info('Update task in storages: $e');
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    final updatedTasks = [
      for (final t in state.tasks)
        if (t.id != event.task.id) t else null
    ];
    emit(state.copyWith(
        tasks: updatedTasks.where((t) => t != null).cast<Task>().toList()));
    logger.info('Delete task from temp array');
    try {
      await _repository.deleteTask(event.task.id);
      logger.info('Delete task from storages: ${event.task}');
    } on Exception catch (e) {
      logger.info('Delete task from storages: $e');
    }
  }

  Future<void> _onToggleVisibilityCompletedFilter(
      ToggleVisibilityCompletedFilter event, Emitter<TasksState> emit) async {
    emit(state.copyWith(completedVisible: !state.completedVisible));
    logger.info(
        'Toggle visibility tasks filter: completed tasks ${!state.completedVisible ? 'visible' : 'invisible'}');
  }
}
