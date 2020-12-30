import 'package:providerassignment/delete_Widget.dart';
import 'package:providerassignment/task_model.dart';
import 'package:flutter/material.dart';
import 'NewTasks.dart';
import 'DB_helper.dart';
import 'package:provider/provider.dart';
import 'package:providerassignment/app_provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}
//
//
//

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return AppProvider();
      },
      child: MaterialApp(
        title: 'Tab Screen',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TabBarPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SplashScreen(
//       seconds: 6,
//       navigateAfterSeconds: new TabBarPage(),
//       title: new Text(
//         'ToDo App',
//         textScaleFactor: 2,
//         style: TextStyle(color: Colors.blue),
//       ),
//       loadingText: Text("Loading"),
//       photoSize: 100.0,
//       loaderColor: Colors.blue,
//     );
//   }
// }

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Task> tasks;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

//
//
//
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Todo'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'All Tasks',
            ),
            Tab(
              text: 'Complete Tasks',
            ),
            Tab(
              text: 'Incomplete Tasks',
            ),
          ],
          isScrollable: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [AllTasks(tasks), CompleteTasks(), IncompleteTasks()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return NewTasks();
            },
          ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

//
class AllTasks extends StatefulWidget {
  List<Task> tasks;
  AllTasks(this.tasks);

  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  deleteFun(e) {
    setState(() {});
    Provider.of<AppProvider>(context, listen: false).deleteTasks(e);
  }

  Widget getTaskWidgets(List<Task> data) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < data.length; i++) {
      list.add(deleteWidget(data[i], deleteFun));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return AppProvider();
        },
        child: Container(
          child: FutureBuilder<List<Task>>(
            future: Provider.of<AppProvider>(context, listen: false)
                .selectAllTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Task> data = snapshot.data;

                return ListView(
                  children: [
                    getTaskWidgets(data),
                  ],
                );
              }
            },
          ),
        ));
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  myFun() {
    setState(() {});
  }

  deleteFun(e) {
    setState(() {});
    Provider.of<AppProvider>(context, listen: false).deleteTasks(e);
  }

  Widget getTaskWidgets(List<Task> data) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < data.length; i++) {
      list.add(deleteWidget(data[i], deleteFun, myFun));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return AppProvider();
        },
        child: Container(
          child: FutureBuilder<List<Task>>(
            future: Provider.of<AppProvider>(context, listen: false)
                .selectSpecificTask(1),
            // DBHelper.dbHelper.selectSpecificTask(1),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Task> data = snapshot.data;
                return ListView(
                  children: [
                    getTaskWidgets(data),
                  ],
                );
              }
            },
          ),
        ));
  }
}

class IncompleteTasks extends StatefulWidget {
  @override
  _IncompleteTasksState createState() => _IncompleteTasksState();
}

class _IncompleteTasksState extends State<IncompleteTasks> {
  myFun() {
    setState(() {});
  }

  deleteFun(e) {
    setState(() {});
    Provider.of<AppProvider>(context, listen: false).deleteTasks(e);
  }

  Widget getTaskWidgets(List<Task> data) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < data.length; i++) {
      list.add(deleteWidget(data[i], deleteFun, myFun));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return AppProvider();
        },
        child: Container(
          child: FutureBuilder<List<Task>>(
            future: Provider.of<AppProvider>(context, listen: false)
                .selectSpecificTask(0),
            // DBHelper.dbHelper.selectSpecificTask(0),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Task> data = snapshot.data;
                return ListView(
                  children: [
                    getTaskWidgets(data),
                  ],
                );
              }
            },
          ),
        ));
  }
// class Secreen1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Provider'),
//       ),
//       body: Container(
//         child: Consumer<AppProvider>(
//           builder: (context, value, child) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text('my name is ${value.name}'),
//                 Text('my address is ${value.address}'),
//                 // Text('my name is ${Provider.of<AppProvider>(context).name}'),
//                 // Text('my address is ${Provider.of<AppProvider>(context).address}'),
//                 // Text('my address is ${context.watch<AppProvider>().address}'),
//                 RaisedButton(onPressed: () {
//                   value.setValues('rana', 'gaza');
//                   // Provider.of<AppProvider>(context, listen: false)
//                   //     .setValues('hala', 'gaza');
//                   // context.read<AppProvider>().setValues('rana', "address");
//                 })
//               ],
//             );
//           },
//         ),
//       ),
//     );
  // }
// }
}
