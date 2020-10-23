import 'package:checklist_app/model/AppUser.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

/*
  static Stream<QuerySnapshot> getChildrenStream(String parentID) {
    return _fireStoreDataBase
        .collection('tasks')
        .where("parents", arrayContains: Parent("userID", parentID).toJson())
        .snapshots();
  }

  static Stream<DocumentSnapshot> getTaskStream(String taskID) {
    return _fireStoreDataBase.collection('tasks').doc(taskID).snapshots();
  }
*/
  static moveTask(Task taskToMove,String targetTaskID, String userID) {
    String currentParentID = taskToMove.getParentID(userID);
    taskToMove.parentObjects.forEach((parentObj) {
      if(parentObj.parentID == currentParentID && parentObj.parentID != Task.getRoot().id)
        parentObj.parentID = targetTaskID;
    });
    _fireStoreDataBase.collection("tasks").doc(taskToMove.id).update({
      "parentObjects": taskToMove.parentObjects.map((e) => e.toJson()).toList(),
      "parentIDs": [targetTaskID],
    });
  }

  static addTask(String taskName, String parentID, String userID) {
    var addTaskData = Map<String, dynamic>();
    addTaskData['title'] = taskName;
    addTaskData['parentObjects'] = [Parent(parentID, userID).toJson()];
    addTaskData['parentIDs'] = [parentID];
    addTaskData['childrenNumber'] = 0;
    addTaskData['childrenSum'] = 0;
    //addTaskData['caseSearch'] = setSearchParam(taskName);
    return _fireStoreDataBase.collection('tasks').add(addTaskData);
  }

  static deleteTask(String taskID) async {
    _fireStoreDataBase.collection('tasks').doc(taskID).delete();
  }

  static checkTask(Task task) {
    _fireStoreDataBase.collection("tasks").doc(task.id).update({
      "childrenSum": task.childrenSum,
    });
  }

  static Future<Task> getTask(String taskID) async {
    DocumentSnapshot doc =
        await _fireStoreDataBase.collection('tasks').doc(taskID).get();
    Task task = Task.fromJson(doc.data());
    task.id = doc.id;
    return task;
  }

  static setSearchParam(String taskName) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < taskName.length; i++) {
      temp = temp + taskName[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  static addUser(AppUser user) async {
    ///todo controlla che non ci sia già un utente con lo stesso nome nel database
    if (user != null) {
      final QuerySnapshot querySnapshot = await _fireStoreDataBase
          .collection("users")
          .where("userID", isEqualTo: user.uid)
          .get();
      final List<DocumentSnapshot> docs = querySnapshot.docs;

      if (docs.length == 0) {
        _fireStoreDataBase.collection('users').doc(user.uid).set({
          "email": user.email,
          "photoURL": user.photoURL,
        });
      } else {
        print("the user is already added");
      }
    } else {
      print("the user from auth is null");
    }
  }

  static Future<bool> share(Task task, String email) async {
    //create a new document of a task with id of the new user and a collection of users data?
    final QuerySnapshot querySnapshot = await _fireStoreDataBase
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    final List<DocumentSnapshot> docs = querySnapshot.docs;
    if (docs != null) {
      print("user trovato");
      docs.forEach((element) {
        print(element.data().toString());
      });

      ///todo associare una task a uno user
      DocumentSnapshot userRef = docs.first;
      task.parentObjects.add(Parent(Task.getRoot().id, userRef.id));
      _fireStoreDataBase.collection("tasks").doc(task.id).update({
        "parentObjects": task.parentObjects.map((e) => e.toJson()).toList(),
        "parentIDs": FieldValue.arrayUnion(task.parentIDs),
      });
      return true;
    }
    return false;
  }
}
