import 'package:flutter/material.dart';
import '../../../../../../firebase_functions/firebase_function.dart';
import '../../../../../../models/task_model.dart';

class TasksProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getTasks(String userId) async {
    List<TaskModel> allTasks = await FirebaseFunction.getTasksFromFireStore(userId);
    tasks = allTasks.where(
      (task) =>
          task.date.year == selectedDate.year &&
          task.date.month == selectedDate.month &&
          task.date.day == selectedDate.day,
    ).toList();
    notifyListeners();
  }

  void getSelectedDateTask(DateTime date, String userId) {
    selectedDate = date;
    getTasks(userId);
  }

  void resetData() {
    tasks = [];
    selectedDate = DateTime.now();
  }
}
