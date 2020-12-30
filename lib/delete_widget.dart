import 'package:provider/provider.dart';
import 'package:providerassignment/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DB_helper.dart';
import 'app_provider.dart';

class deleteWidget extends StatefulWidget {
  Task task;
  Function function;
  Function function1;
  deleteWidget(this.task, [this.function1, this.function]);

  @override
  _deleteWidgetState createState() => _deleteWidgetState();
}

class _deleteWidgetState extends State<deleteWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return AppProvider();
        },
        child: Card(
          shadowColor: Colors.blue,
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text("Alert"),
                                content: Text("Are you sure?"),
                                actions: <Widget>[
                                  FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        widget.function1(widget.task);
                                        Navigator.of(context).pop();
                                      }),
                                  FlatButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })
                                ]);
                          });
                    }),
                Text(widget.task.taskTitle),
                Checkbox(
                    value: widget.task.isComplete,
                    onChanged: (value) {
                      Provider.of<AppProvider>(context, listen: false)
                          .updateOnTasks(
                              widget.task.id,
                              widget.task.taskTitle,
                              this.widget.task.isComplete =
                                  !this.widget.task.isComplete);

                      setState(() {});
                      widget.function();
                    })
              ],
            ),
          ),
        ));
  }
}
