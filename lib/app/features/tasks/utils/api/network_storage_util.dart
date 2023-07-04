import 'package:to_do_application/app/core/common/custom_exceptions.dart';
import 'package:to_do_application/app/core/common/logger.dart';
import 'package:to_do_application/app/core/utils/network_util.dart';
import 'package:to_do_application/app/core/utils/persistence_util.dart';
import 'package:to_do_application/app/features/tasks/data/response.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';

class NetworkStorage {
  final NetworkUtil _networkUtil;
  final PersistenceUtil _persistenceUtil;

  NetworkStorage(
      {required NetworkUtil networkUtil,
      required PersistenceUtil persistenceUtil})
      : _networkUtil = networkUtil,
        _persistenceUtil = persistenceUtil;

  Future<ResponseData<Task>> addTask(Task task) async {
    final requestData = <String, dynamic>{'element': task.toJson()};
    try {
      final response = await _networkUtil.post('/list', requestData);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info('Add task to network storage: ${task.toJson()}');
        final data = Task.fromJson(json['element']);

        final revision = json['revision'] as int;
        await _persistenceUtil.saveTasksRevision(revision: revision);
        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetCustomException catch (e) {
      logger.info('Add task to network storage error: $e');
      return ResponseData.error(503);
    } on ResponseCustomException catch (e) {
      logger.info('Add task to network storage error: $e');
      return ResponseData.error(500);
    } on UnknownNetworkCustomException catch (e) {
      logger.info('Add task to network storage error: $e');
      return ResponseData.error(400);
    } on Exception catch (e) {
      logger.info('Add task to network storage error: $e');
      return ResponseData.error(500);
    }
  }

  Future<ResponseData<Task>> deleteTask(String id) async {
    try {
      final response = await _networkUtil.delete('/list/$id');
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info(
            'Delete task from network storage: $id, ${response.statusMessage}');
        final data = Task.fromJson(json['element']);
        final revision = json['revision'] as int;
        await _persistenceUtil.saveTasksRevision(revision: revision);
        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetCustomException catch (e) {
      logger.info('Delete task from network storage error: $e');
      return ResponseData.error(503);
    } on ResponseCustomException catch (e) {
      logger.info('Delete task from network storage error: $e');
      return ResponseData.error(500);
    } on UnknownNetworkCustomException catch (e) {
      logger.info('Delete task from network storage error: $e');
      return ResponseData.error(400);
    } on Exception catch (e) {
      logger.info('Delete task from network storage error: $e');
      return ResponseData.error(500);
    }
  }

  Future<ResponseData<Task>> getTask(String id) async {
    try {
      final response = await _networkUtil.get('/list/$id');
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info(
            'Get task from network storage: $id, ${response.statusMessage}');
        final data = Task.fromJson(json['element']);

        final revision = json['revision'] as int;
        await _persistenceUtil.saveTasksRevision(revision: revision);

        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetCustomException catch (e) {
      logger.info('Get task from network storage error: $e');
      return ResponseData.error(503);
    } on ResponseCustomException catch (e) {
      logger.info('Get task from network storage error: $e');
      return ResponseData.error(400);
    } on UnknownNetworkCustomException catch (e) {
      logger.info('Get task from network storage error: $e');
      return ResponseData.error(500);
    } on Exception catch (e) {
      logger.info('Get task from network storage error: $e');
      return ResponseData.error(500);
    }
  }

  Future<ResponseData<List<Task>>> getTasks() async {
    try {
      final response = await _networkUtil.get('/list');

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info(
            'Get tasks from network storage: length ${(json['list'] as List<dynamic>).length} ${response.statusMessage}');
        final listJson = json['list'] as List<dynamic>;
        final data = listJson
            .map((e) => Task.fromJson(e as Map<String, dynamic>))
            .toList();

        final revision = json['revision'] as int;

        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetCustomException catch (e) {
      logger.info('Get tasks from network storage error: $e');
      return ResponseData.error(503);
    } on ResponseCustomException catch (e) {
      logger.info('Get tasks from network storage error: $e');
      return ResponseData.error(400);
    } on UnknownNetworkCustomException catch (e) {
      logger.info('Get tasks from network storage error: $e');
      return ResponseData.error(500);
    } on Exception catch (e) {
      logger.info('Get tasks from network storage error: $e');
      return ResponseData.error(500);
    }
  }

  Future<ResponseData<Task>> updateTask(Task task) async {
    final requestData = {'element': task.toJson()};
    try {
      final response = await _networkUtil.put('/list/${task.id}', requestData);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info(
            'Update task in network storage: $task ${response.statusMessage}');
        final data = Task.fromJson(json['element']);

        final revision = json['revision'] as int;
        await _persistenceUtil.saveTasksRevision(revision: revision);

        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetCustomException catch (e) {
      logger.info('Update task in network storage error: $e');
      return ResponseData.error(503);
    } on ResponseCustomException catch (e) {
      logger.info('Update task in network storage error: $e');
      return ResponseData.error(400);
    } on UnknownNetworkCustomException catch (e) {
      logger.info('Update task in network storage error: $e');
      return ResponseData.error(500);
    } on Exception catch (e) {
      logger.info('Update task in network storage error: $e');
      return ResponseData.error(500);
    }
  }

  Future<ResponseData<List<Task>>> syncTasks(List<Task> tasks) async {
    final requestData = <String, dynamic>{
      'list': tasks.map((task) => task.toJson()).toList(),
    };
    try {
      final response = await _networkUtil.patch('/list', requestData);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info(
            'Sync tasks from network storage and local storage: ${response.statusMessage}');
        final listJson = json['list'] as List<dynamic>;
        final data = listJson
            .map((e) => Task.fromJson(e as Map<String, dynamic>))
            .toList();

        final revision = json['revision'] as int;
        await _persistenceUtil.saveTasksRevision(revision: revision);

        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetCustomException catch (e) {
      logger.info('Sync tasks from network storage error: $e');
      return ResponseData.error(503);
    } on ResponseCustomException catch (e) {
      logger.info('Sync tasks from network storage error: $e');
      return ResponseData.error(400);
    } on UnknownNetworkCustomException catch (e) {
      logger.info('Sync tasks from network storage error: $e');
      return ResponseData.error(500);
    } on Exception catch (e) {
      logger.info('Sync tasks from network storage error: $e');
      return ResponseData.error(500);
    }
  }
}
