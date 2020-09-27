import 'package:checklist_app/controller/Storage.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:checklist_app/view/home/AddButton.dart';
import 'package:checklist_app/view/tasks/ParentTaskItem.dart';
import 'package:checklist_app/view/tasks/TaskPath.dart';
import 'package:checklist_app/view/tasks/tasksList/TasksList.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final Storage storage = Storage();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  //sta roba fa cagare da fare coi futures!!
  Task selectedTask;
  List<Task> selectedTaskPath;
  Task root = Task.emptyRoot;
  Task task = Task.emptyRoot;
  List<Task> taskPath = List<Task>();

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((Task value) {
      setState(() {
        //sta roba fa cagare da fare coi futures!!
        root = value;
        task = root;
        taskPath.add(root);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          backToTask(taskPath[taskPath.length - 2]);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              TaskPath(taskPath, backToTask),
              ParentTaskItem(task),
              TasksList(task, openTask, updateTaskPathPercentage, selectTask),
            ],
          ),
          floatingActionButton: AddButton(selectedTask, addTask, moveTask),
        ),
      ),
    );
  }

  //tutte ste robe da mettere nel controller

  void selectTask(Task task) {
    setState(() {
      selectedTask = task;
      selectedTaskPath = List.from(taskPath);
    });
  }

  void updateSelectedTaskPathPercentage() {
    setState(() {
      selectedTaskPath.reversed.forEach((task) {
        task.updatePercentage();
      });
    });
    widget.storage.writeData(root);
  }

  void updateTaskPathPercentage() {
    setState(() {
      taskPath.reversed.forEach((task) {
        task.updatePercentage();
      });
    });
    widget.storage.writeData(root);
  }

  void addTask(String title) {
    setState(() {
      task.children.add(Task(title));
    });
    widget.storage.writeData(root);
  }

  void backToTask(Task task) {
    setState(() {
      taskPath.removeRange(taskPath.indexOf(task) + 1, taskPath.length);
      this.task = task;
    });
  }

  void openTask(Task task) {
    setState(() {
      taskPath.add(task);
      this.task = task;
    });
  }

  void moveTask() {
    setState(() {
      selectedTaskPath.last.children.remove(selectedTask);
      updateSelectedTaskPathPercentage();

      task.children.add(selectedTask);
      updateTaskPathPercentage();

      selectedTask = null;
    });
  }
}