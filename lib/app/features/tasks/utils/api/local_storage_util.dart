import 'package:sqflite/sqflite.dart';
import 'package:to_do_application/app/core/common/logger.dart';
import 'package:to_do_application/app/core/utils/data_base_util.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';
import 'package:to_do_application/app/features/tasks/utils/api/api.dart';

class LocalStorageUtil implements Api {
  late final Database database;

  Future<void> init() async {
    database = await DatabaseUtil.dbProvider.database;
  }

  Future<void> deleteAllTasks() async {
    await database.delete('tasks');
  }

  @override
  Future<Task> addTask(Task task) async {
    await database.insert('tasks', task.toJson());
    logger.info('Add task in localStorage: ${task.toJson()}');
    return task;
  }

  @override
  Future<void> deleteTaskWithoutInternet(String id) async {
    await database.update('tasks', {'deleted': 1},
        where: 'id = ?', whereArgs: [id]);
    logger.info('Wait for deleting task from server');
  }

  @override
  Future<void> deleteTask(String id) async {
    await database.delete('tasks', where: 'id = ?', whereArgs: [id]);
    logger.info('Delete task from localStorage: $id');
  }

  @override
  Future<Task> getTask(String id) async {
    final result =
        await database.query('tasks', where: 'id = ?', whereArgs: [id]);
    logger.info('Get task from localStorage: ${Task.fromJson(result.first)}');
    return Task.fromJson(result.first);
  }

  @override
  Future<List<Task>> getTasks() async {
    final result = await database.query('tasks');
    logger.info('Get tasks from localStorage length: ${result.length}');
    return result.map(Task.fromJson).toList();
  }

  @override
  Future<Task> updateTask(Task task) async {
    final result = await database.update('tasks', task.toJson().toDBJson(),
        where: 'id = ?', whereArgs: [task.id]);
    if (result == 0) {
      throw Exception('Task with id ${task.id} not found');
    }
    logger.info('Update task in localStorage: ${task.toJson()}');
    return task;
  }
}
