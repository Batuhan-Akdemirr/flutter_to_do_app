
import 'package:to_do_application/data/local_storage.dart';
import 'package:to_do_application/models/task_model.dart';

class HiveLocalStorage implements LocalStorage{
  @override
  Future<void> addTask({required Task task}) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTask({required Task task}) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTask() {
    // TODO: implement getAllTask
    throw UnimplementedError();
  }

  @override
  Future<Task> getTask({required String id}) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<Task> updateTask({required Task task}) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
  
}