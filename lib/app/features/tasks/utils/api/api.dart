import 'package:to_do_application/app/features/tasks/data/task_model.dart';

abstract class Api {
  Future<List<Task>> getTasks();
  Future<Task> getTask(String id);
  Future<Task> addTask(Task task);
  Future<Task> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> deleteTaskWithoutInternet(String id);
}
