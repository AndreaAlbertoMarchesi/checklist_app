import 'package:checklist_app/controller/Storage.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:checklist_app/view/home/AddButton.dart';
import 'package:checklist_app/view/task/TaskItem.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  HomeState();

  Task root = Task("root", <Task>[]);
  final Storage storage = Storage();
  TaskItemState selection;

  /*
  root da fare come future, e poi usare il future builder per
  fare la lista primaria
   */

  @override
  void initState() {
    super.initState();
    storage.readData().then((Task value) {
      setState(() {
        root = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        child: Scaffold(
          appBar: AppBar(
            title: Text("title"),
          ),

          //usare future builder

          body: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                TaskItem(root.children[index], _setSelection),
            itemCount: root.children.length,
          ),
          floatingActionButton: AddButton(addTask),
        ),
        onTap: () {
          if (selection != null) {
            selection.deselect();
            selection = null;
          }
        },
      ),
    );
  }

  void _setSelection(TaskItemState newSelection) {
    setState(() {
      if (selection != null) selection.deselect();
      selection = newSelection;
    });
  }

  void addTask() {
    storage.writeData(root);

    if (selection != null)
      selection.addTask();
    else
      setState(() {
        root.children.add(Task());
      });
  }
}
