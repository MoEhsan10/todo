import 'package:flutter/material.dart';
import '../../../../../../firebase_functions/firebase_function.dart';
import '../../../../../../models/task_model.dart';

class TasksProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getTasks() async {
    List<TaskModel> allTasks = await FirebaseFunction.getTasksFromFireStore();
    tasks = allTasks.where(
            (task) =>
            task.date.year == selectedDate.year &&
            task.date.month == selectedDate.month &&
            task.date.day == selectedDate.day
    ).toList();
    notifyListeners();
  }

  void getSelectedDateTask(DateTime date) {
    selectedDate = date;
    getTasks();
  }
}
