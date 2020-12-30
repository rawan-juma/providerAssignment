import 'package:provider/provider.dart';
import 'package:providerassignment/task_model.dart';
import 'package:flutter/material.dart';
import 'DB_helper.dart';
import 'app_provider.dart';

class NewTasks extends StatefulWidget {
  @override
  _NewTasksState createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  int id;
  bool isComplete = false;
  String taskTitle;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return AppProvider();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('New Task'),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onChanged: (value) {
                    this.taskTitle = value;
                  },
                ),
                //
                Checkbox(
                  value: isComplete,
                  onChanged: (value) {
                    this.isComplete = value;
                    setState(() {});
                  },
                ),
                RaisedButton(
                    child: Text('Add New Task'),
                    onPressed: () {
                      // DBHelper.dbHelper.insertNewTask(
                      //     Task(this.taskTitle, this.isComplete, this.id));
                      Provider.of<AppProvider>(context, listen: false)
                          .insertTasks(id, taskTitle, isComplete);

                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ));
  }
}
