import 'package:checklist_app/controller/Storage.dart';
import 'package:checklist_app/services/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Task.dart';

class AppState extends ChangeNotifier {
  List<Task> taskPath = List<Task>();

  List<Task> tasks = List<Task>();
  Task currentTask = Task(null);

  List<Task> selectedListOfTasks = [];
  List<List<Task>> selectedListOfTasksPath = [];


  openTask(Task task){
    currentTask = task;
    notifyListeners();
    print("done");
  }

  addTask(String name){
    Database.instance.addTask(name, currentTask.id);
    notifyListeners();
  }

  void selectTask(Task task) {

    if(!selectedListOfTasks.contains(task)) {
      selectedListOfTasks.add(task);
      List<Task> cloneOfTaskPath = new List<Task>.from(taskPath);
      selectedListOfTasksPath.add(cloneOfTaskPath);
    }
    notifyListeners();
  }

  void unDoSelection() {
    selectedListOfTasks.clear();
    selectedListOfTasksPath.clear();
    notifyListeners();
  }

  backToPreviousTask() async {
    if (currentTask.getParent("userID")!=null) {
      currentTask = await Database.getTask(currentTask.getParent("userID"));
      notifyListeners();
    }
  }

  void backToRoot() {
    notifyListeners();
  }
}
