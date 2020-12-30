import 'package:providerassignment/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static final String databaseName = 'tasksDB.db';
  static final String tableName = 'tasks';
  static final String taskIdColumn = 'id';
  static final String taskTitleColumn = 'title';
  static final String taskIsCompleteColumn = 'isComplete';
  Database database;
  Future<Database> initDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  Future<Database> createDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, databaseName);
      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''CREATE TABLE $tableName(
        $taskIdColumn INTEGER PRIMARY KEY AUTOINCREMENT ,
        $taskTitleColumn TEXT NOT NULL ,
        $taskIsCompleteColumn INTEGER 
        )''');
        },
      );
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTask(Task task) async {
    try {
      database = await initDatabase();
      int x = await database.insert(tableName, task.toJson());
      print(x);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Task>> selectAllTasks() async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName);
      List<Task> tasks = result.map((e) => Task.fromJson(e)).toList();
      return tasks;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Task>> selectSpecificTask(int isComplete) async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName,
          where: '$taskIsCompleteColumn=?', whereArgs: [isComplete]);
      List<Task> tasks = result.map((e) => Task.fromJson(e)).toList();
      return tasks;
    } on Exception catch (e) {
      print(e);
    }
  }

  updateTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database.update(tableName, task.toJson(),
          where: '$taskIdColumn=?', whereArgs: [task.id]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

//
  deleteTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database
          .delete(tableName, where: '$taskIdColumn=?', whereArgs: [task.id]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }
}
