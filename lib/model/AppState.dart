import 'package:checklist_app/controller/Storage.dart';
import 'package:flutter/cupertino.dart';

import 'Task.dart';

class AppState extends ChangeNotifier {
  Storage storage = Storage();
  Task selectedTask;
  List<Task> selectedTaskPath;
  Task root = Task.emptyRoot;
  Task task = Task.emptyRoot;
  List<Task> taskPath = List<Task>();

  ///da migliorare => inseriti per il poter selezionare più di un elemento da spostare
  List<Task> selectedTasks = [];
  List<Task> lastTaskPath;

  AppState() {
    storage.readData().then((Task value) {
      root = value;
      task = root;
      taskPath.add(root);
      notifyListeners();
    });
  }

  void selectTask(Task task) {
    if (selectedTask == null) {
      selectedTask = task;
      selectedTasks.add(selectedTask);
      selectedTaskPath = List.from(taskPath);
      lastTaskPath =
          selectedTaskPath.toList().sublist(0, selectedTaskPath.length - 1);
    } else {
      selectedTaskPath = List.from(taskPath).sublist(0, taskPath.length - 1);
      if (selectedTaskPath == lastTaskPath) {
        selectedTasks.add(task);
      } else {
        selectedTask = task;
        selectedTaskPath = List.from(taskPath);
        lastTaskPath = selectedTaskPath;
        selectedTasks.clear();
      }
    }
    notifyListeners();
  }

  void unDoSelection() {
    selectedTask = null;
    notifyListeners();
  }

  void updateSelectedTaskPathPercentage() {
    selectedTaskPath.reversed.forEach((task) {
      task.updatePercentage();
    });
    storage.writeData(root);
    notifyListeners();
  }

  void updateTaskPathPercentage() {
    taskPath.reversed.forEach((task) {
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
    updateTaskPathPercentage();
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
    taskPath.add(task);
    this.task = task;
    notifyListeners();
  }

  void moveTask() {
    selectedTaskPath.last.children.remove(selectedTask);
    updateSelectedTaskPathPercentage();

    task.children.add(selectedTask);
    updateTaskPathPercentage();
    selectedTask = null;

    notifyListeners();
  }
}
