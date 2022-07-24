import 'package:to_do_application/models/task_model.dart';

abstract class LocalStorage {
  Future<void> addTask({required Task tas});
  Future<Task> getTask({required String id});
  Future<List<Task>> getAllTask();
  Future<bool> deleteTask({required Task task});
  Future<Task> updateTask({required Task task});
}
