import 'DB_helper.dart';

class Task {
  int id;
  String taskTitle;
  bool isComplete;
  Task(this.taskTitle, this.isComplete, [this.id]);
  Task.fromJson(Map map) {
    this.id = map[DBHelper.taskIdColumn];
    this.taskTitle = map[DBHelper.taskTitleColumn];
    //
    //
    this.isComplete = map[DBHelper.taskIsCompleteColumn] == 1 ? true : false;
  }

  toJson() {
    return {
      DBHelper.taskIdColumn: this.id,
      DBHelper.taskTitleColumn: this.taskTitle,
      DBHelper.taskIsCompleteColumn: this.isComplete ? 1 : 0,
    };
  }
}
