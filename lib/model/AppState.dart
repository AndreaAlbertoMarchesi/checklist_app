import 'package:checklist_app/controller/Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Task.dart';

class AppState extends ChangeNotifier {
  Storage storage = Storage();
  Task root = Task.emptyRoot;
  Task task = Task.emptyRoot;
  List<Task> taskPath = List<Task>();

  List<Task> selectedListOfTasks = [];
  List<List<Task>> selectedListOfTasksPath = [];

  AppState() {
    storage.readData().then((Task value) {
      root = value;
      task = root;
      taskPath.add(root);
      notifyListeners();
    });
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


  void updateTaskPathPercentage(List<Task> tp) {
    tp.reversed.forEach((task) {
      task.updatePercentage();
    });
    storage.writeData(root);
    notifyListeners();
  }

  void addTask(String title) {
    task.children.add(Task(title));
    print(taskPath.map((e) => e.title).toString());
    storage.writeData(root);
    notifyListeners();
  }

  void deleteTask(Task task, Task parent) {
    parent.children.remove(task);
    updateTaskPathPercentage(taskPath);
    storage.writeData(root);
    notifyListeners();
  }

  void backToTask(Task task) {
    taskPath.removeRange(taskPath.indexOf(task) + 1, taskPath.length);
    this.task = task;
    notifyListeners();
  }

  void backToPreviousTask() {
    if (taskPath.length > 1) {
      taskPath.removeLast();
      this.task = taskPath.last;
      notifyListeners();
    }
  }

  void backToRoot() {
    taskPath.clear();
    taskPath.add(root);
    this.task = root;
    notifyListeners();
  }

  void openTask(Task task) {
    if(!selectedListOfTasks.contains(task)) {
      taskPath.add(task);
      this.task = task;
      notifyListeners();
    }
  }

  void moveTask() {
    
    for(List<Task> tsp in selectedListOfTasksPath){
      Task tempTask = selectedListOfTasks.first;
      tsp.last.children.remove(tempTask);
      updateTaskPathPercentage(tsp.last.children);

      task.children.add(tempTask);
      selectedListOfTasks.remove(tempTask);
      updateTaskPathPercentage(taskPath);
    }
    selectedListOfTasks.clear();
    selectedListOfTasksPath.clear();

    notifyListeners();
  }

  void handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final element = task.children.removeAt(oldIndex);
    task.children.insert(newIndex, element);

    notifyListeners();
  }
}
