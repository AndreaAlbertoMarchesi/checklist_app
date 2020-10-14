import 'package:checklist_app/model/Task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

  //receive the data
  Stream<List<Task>> getTaskList() {
    return _fireStoreDataBase.collection('tasks')
        .snapshots()
        .map((snapShot) => snapShot.docs
        .map((document) => Task.fromJson(document.data()))
        .toList());
  }

  //upload a data
  addTask(){
    var addTaskData = Map<String,dynamic>();
    addTaskData['title'] = "title";
    addTaskData['children'] = List<Task>();
    return _fireStoreDataBase.collection('tasks').doc().set(addTaskData);
  }
}