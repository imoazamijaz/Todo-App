import 'package:get/get.dart';
import '../db_helper/db_helper.dart';
import '../model/task_model.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    loadTasks();
    super.onInit();
  }

  Future<void> loadTasks() async {
    var tasks = await _dbHelper.getTasks();
    taskList.assignAll(tasks);
  }

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task);
    loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    loadTasks();
  }

  void toggleTaskStatus(Task task) {
    task.isCompleted = task.isCompleted == 0 ? 1 : 0;
    updateTask(task);
  }
}
