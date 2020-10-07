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

    if(selectedTask == null) {
      selectedTask = task;
      selectedTasks.add(selectedTask);
      selectedTaskPath = List.from(taskPath);
      lastTaskPath = selectedTaskPath.toList().sublist(0,selectedTaskPath.length-1);
    }else {
      selectedTaskPath = List.from(taskPath).sublist(0,taskPath.length-1);
      if(selectedTaskPath == lastTaskPath){
        selectedTasks.add(task);
      }else {
        selectedTask = task;
        selectedTaskPath = List.from(taskPath);
        lastTaskPath = selectedTaskPath;
        selectedTasks.clear();
      }
    }
    notifyListeners();
  }

  void unDoSelection(){
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
    /*List<Task> taskPathToMemorize = new List<Task>();
    taskPathToMemorize.addAll(taskPath);
    Task taskToMemorize =Task(title);
    taskPathToMemorize.add(Task(title));

    taskToMemorize.setTaskPathToMemorize(encode(taskPathToMemorize));
    task.children.add(taskToMemorize);
    mapOfTask.putIfAbsent(title, () => taskToMemorize);

    print(taskPath.map((e) => e.title).toString());
*/
    storage.writeData(root);
    notifyListeners();
  }

  void deleteTask(Task task, Task parent){
    parent.children.remove(task);
    ///mapOfTask.remove(task.title);
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
  void backToRoot(){
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

    /*List<Task> taskPathToMemorize = new List<Task>();
    taskPathToMemorize.addAll(taskPath);
    taskPathToMemorize.add(selectedTask);

    selectedTask.setTaskPathToMemorize(encode(taskPathToMemorize));*/
    selectedTask = null;

    notifyListeners();
  }
/*

  void goToTask(String title){

    List<dynamic> pathConverted;

    String pathWanted = mapOfTask['$title'].taskPathToMemorize;
    pathConverted = decode(pathWanted);
    createPath(pathConverted);

    print(pathWanted);
  }

  Task getTaskFromTitle(String title){
    return mapOfTask['$title'];
  }

  String encode(List<Task> toEncode){
    List<String> titles = toEncode.map((e) => e.title).toList();
    String encoded="";
    for(String title in titles ){
      encoded = encoded + "$title£";
    }
    return encoded;
  }

  List<String> decode(String toDecode){
    List<String> titles=[];
    String title = "";
    for(int i=0; i < toDecode.length; i++  ){
      int j;
      for(j = i; toDecode[j] != "£"; j++){
        title = title + toDecode[j];
      }
      i = j;
      titles.add(title);
      title = "";
    }
    return titles;
  }

  void createPath(List<String> titles) {
    titles= titles.sublist(1,titles.length);
    taskPath.clear();
    taskPath.add(root);
    task = root;
    for(String title in titles){
      task = task.children.firstWhere((element) => element.title == title);
      taskPath.add(task);
    }
    notifyListeners();
  }
  //used to suggestionlist
  List<String> fillTitles(){
    List<String> titles=[];
    mapOfTask.forEach((key, value) { titles.add(value.title); });
    return titles;
  }

*/

}
