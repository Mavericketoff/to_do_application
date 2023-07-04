import 'package:to_do_application/app/core/utils/network_util.dart';
import 'package:to_do_application/app/core/utils/persistence_util.dart';
import 'package:to_do_application/app/features/tasks/data/response.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';
import 'package:to_do_application/app/features/tasks/utils/api/api.dart';
import 'package:to_do_application/app/features/tasks/utils/api/network_storage_util.dart';

class Repository {
  Repository({
    required NetworkUtil networkUtil,
    required PersistenceUtil persistenceUtil,
    required this.localStorage,
  }) : _persistenceUtil = persistenceUtil {
    networkStorage = NetworkStorage(
        persistenceUtil: persistenceUtil, networkUtil: networkUtil);
  }

  final PersistenceUtil _persistenceUtil;
  final Api localStorage;
  late final NetworkStorage networkStorage;

  Future<bool> checkChanges() async {
    final networkStorageTasks = (await networkStorage.getTasks()).data ?? [];
    final localTasks = await localStorage.getTasks();
    return !networkStorageTasks.every(localTasks.contains) ||
        !localTasks.every(networkStorageTasks.contains);
  }

  Future<void> syncStorages() async {
    final network = await networkStorage.getTasks();
    if (await _persistenceUtil.getTasksRevision() != network.revision ||
        await checkChanges()) {
      await _persistenceUtil.saveTasksRevision(revision: network.revision ?? 0);
      final localTasks = await getLocalTasks();

      if (network.data != null) {
        final localTasksMap = <String, Task>{
          for (var task in localTasks) task.id: task
        };
        for (final task in network.data!) {
          if (!localTasksMap.containsKey(task.id)) {
            await localStorage.addTask(task);
          } else {
            final tempTask = localTasksMap[task.id];
            if (tempTask!.changedAt.isBefore(task.changedAt)) {
              await localStorage.updateTask(task);
            } else if (tempTask.deleted != null && tempTask.deleted!) {
              await localStorage.deleteTask(tempTask.id);
            }
          }
        }
      }
      await networkStorage.syncTasks(await localStorage.getTasks());
    }
  }

  Future<List<Task>> getLocalTasks() async {
    final localTasks = await localStorage.getTasks();
    return localTasks;
  }

  Future<List<Task>> getTasks() async {
    await syncStorages();
    return getLocalTasks();
  }

  Future<Task> getTask(String id) async {
    await syncStorages();
    final localTask = await localStorage.getTask(id);
    return localTask;
  }

  Future<Task> addTask(Task task) async {
    final localTask = await localStorage.addTask(task);
    final ResponseData response = await networkStorage.addTask(task);
    if (response.status == 400) {
      await syncStorages();
      await networkStorage.addTask(task);
    }
    return localTask;
  }

  Future<Task> updateTask(Task task) async {
    final localTask = await localStorage.updateTask(task);
    final ResponseData response = await networkStorage.updateTask(task);
    if (response.status == 400) {
      await syncStorages();
      await networkStorage.updateTask(task);
    }
    return localTask;
  }

  Future<void> deleteTask(String id) async {
    await localStorage.deleteTaskWithoutInternet(id);
    final ResponseData response = await networkStorage.deleteTask(id);
    ResponseData? responseAfterSync;
    if (response.status == 400) {
      await syncStorages();
      responseAfterSync = await networkStorage.deleteTask(id);
    }
    if (response.status == 200 ||
        (responseAfterSync != null && responseAfterSync.status == 200)) {
      await localStorage.deleteTask(id);
    }
  }
}
