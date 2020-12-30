import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:providerassignment/task_model.dart';

import 'DB_helper.dart';

class AppProvider extends ChangeNotifier {
  int id;
  String taskTitle;
  bool isComplete = false;
  int numb;
  List<Task> tasks;

  selectAllTasks() {
    return DBHelper.dbHelper.selectAllTasks();
    notifyListeners();
  }

  selectSpecificTask(int numb) {
    this.numb = numb;
    return DBHelper.dbHelper.selectSpecificTask(numb);
    notifyListeners();
  }

  insertTasks(int id, String taskTitle, bool isComplete) {
    this.id = id;
    this.taskTitle = taskTitle;
    this.isComplete = isComplete;
    DBHelper.dbHelper.insertNewTask(Task(taskTitle, isComplete, id));
    notifyListeners();
  }

  deleteTasks(Task) {
    DBHelper.dbHelper.deleteTask(Task);
    notifyListeners();
  }

  updateOnTasks(int id, String taskTitle, bool isComplete) {
    this.id = id;
    this.taskTitle = taskTitle;
    this.isComplete = isComplete;
    DBHelper.dbHelper.updateTask(Task(taskTitle, isComplete, id));
    notifyListeners();
  }
}
