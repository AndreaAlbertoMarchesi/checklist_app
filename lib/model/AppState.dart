import 'dart:async';

import 'package:checklist_app/model/AppUser.dart';
import 'package:checklist_app/services/AuthenticationService.dart';
import 'package:checklist_app/services/Database.dart';
import 'package:checklist_app/view/Settings/SharedPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Task.dart';

class AppState extends ChangeNotifier {
  List<Task> taskPath = List<Task>();

  List<Task> tasks = List<Task>();
  Task parentTask = Task.getRoot();

  List<Task> selectedListOfTasks = [];
  List<List<Task>> selectedListOfTasksPath = [];

  StreamSubscription<QuerySnapshot> childrenListener;
  StreamSubscription<DocumentSnapshot> parentListener;

  AppUser appUser = new AppUser(email: "Anonymous", uid: "Anonymous",photoURL: "https://www.pngitem.com/pimgs/m/524-5246388_anonymous-user-hd-png-download.png");
  final AuthenticationService _auth = AuthenticationService();
  final UserPreference userPreference = new UserPreference();


  AppState(){
    getUserPreferences();
    childrenListener = listenToChildren();
  }

  openTask(Task task){
    parentTask = task;
    resetDatabaseListeners();
    notifyListeners();
  }

  backToPreviousTask() async {
    if(parentTask.id != Task.getRoot().id) {
      if (parentTask.getParentID("userID") != Task
          .getRoot()
          .id)
        parentTask = await Database.getTask(parentTask.getParentID("userID"));
      else
        parentTask = Task.getRoot();

      resetDatabaseListeners();
      notifyListeners();
    }
  }

  addTask(String name){
    Database.addTask(name, parentTask.id);
  }

  deleteTask(Task taskToDelete){
    Database.deleteTask(taskToDelete.id);
  }

  void moveTask() {
    Database.moveTask(selectedListOfTasks.first, parentTask.id);
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



  void backToRoot() {
    notifyListeners();
  }

  void resetDatabaseListeners(){
    if(parentListener!=null)
      parentListener.cancel();
    if(parentTask.id!="root")
      parentListener = listenToParent();

    childrenListener.cancel();
    childrenListener = listenToChildren();
  }


  StreamSubscription<DocumentSnapshot> listenToParent(){
    return FirebaseFirestore.instance.collection('tasks').doc(parentTask.id).snapshots().listen((doc) {
      Task task = Task.fromJson(doc.data());
      task.id = doc.id;
      parentTask = task;
      notifyListeners();
    });
  }

  StreamSubscription<QuerySnapshot> listenToChildren(){
    return FirebaseFirestore.instance.collection('tasks')
        .where("parentObjects", arrayContains: Parent(parentTask.id, "userID").toJson())
        .snapshots().listen((snap) {
      tasks = snap.docs.map((document) {
        Task task = Task.fromJson(document.data());
        task.id = document.id;
        return task;
      }).toList();
      notifyListeners();
    });
  }




  Future<void> getUserPreferences() async{
    appUser = await userPreference.getUser();
    if(appUser == null){
      appUser = new AppUser(email: "Anonymous", uid: "Anonymous",
          photoURL: "https://icon-library.com/images/profile-42914__340.png");
    }
  }

  Future<void> signInWithGoogle() async{
    AppUser user = await _auth.signInWithGoogle();
    if( user != null ){
      appUser = user;
      Database.addUser(appUser);
      await userPreference.setUser(appUser);
    }
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async{
    AppUser user = await _auth.signInWithEmailAndPassword(email, password, appUser.photoURL);
    if(user != null) {
      appUser = user;
      await userPreference.setUser(appUser);
    }
    notifyListeners();
  }

  Future<void> registerWithEmailAndPsw(String email, String password) async{

    AppUser user = await _auth.registerWithEmailAndPassword(email, password, appUser.photoURL);
    if( user != null ){
      Database.addUser(user);
      appUser = user;
      await userPreference.setUser(appUser);
    }
    notifyListeners();
  }

  void signOut() async {
    await _auth.signOut();
    appUser.email = "Anonymous";
    appUser.uid = "Anonymous";
    appUser.photoURL = "https://icon-library.com/images/profile-42914__340.png";
    await userPreference.setUser(appUser);
    notifyListeners();
  }

  ///possiblie toast bar per notificare l'invio
  Future<void> share(Task task, String email) async{
    bool found = await Database.share(task, email);
    if(found){
      print("faccio notifica positiva");
    }else
      print("qualcosa è andato storto");
  }


  /*void updateTaskPathPercentage(List<Task> tp) {
    tp.reversed.forEach((task) {
      task.updatePercentage();
    });
    storage.writeData(root);
    notifyListeners();
  }

  void addTask(String title) {
    task.children.add(Task(title));
    updateTaskPathPercentage(task.children);
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
  }*/

}
