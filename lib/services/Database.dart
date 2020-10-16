import 'dart:async';

import 'package:checklist_app/model/Task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;
  static String userID = "userID";

  static Stream<QuerySnapshot> getChildrenStream(String parentID) {
    return _fireStoreDataBase
        .collection('tasks')
        .where("parents", arrayContains: Parent("userID", parentID).toJson())
        .snapshots();
  }

  static Stream<DocumentSnapshot> getTaskStream(String taskID) {
    return _fireStoreDataBase.collection('tasks').doc(taskID).snapshots();
  }

  static moveTask(String taskID) {
    _fireStoreDataBase.collection("users").doc(taskID).update({
      "parents": 13,
    });
  }

  static addTask(String taskName, String parent) {
    var addTaskData = Map<String, dynamic>();
    addTaskData['title'] = taskName;
    addTaskData['parents'] = [Parent(userID, parent).toJson()];
    return _fireStoreDataBase.collection('tasks').add(addTaskData);
  }

  static Future<Task> getTask(String taskID) async {
    DocumentSnapshot doc =
        await _fireStoreDataBase.collection('tasks').doc(taskID).get();
    Task task = Task.fromJson(doc.data());
    task.id = doc.id;
    return task;
  }
}
