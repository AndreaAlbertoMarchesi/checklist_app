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
  static moveTask(Task taskToMove, Task targetTask, String userID) {
    String currentParentID = taskToMove.getParentID(userID);

    taskToMove.parentIDs.remove(currentParentID);
    _addToPercentage(currentParentID, -1,
        -(taskToMove.childrenSum / taskToMove.childrenNumber));
    taskToMove.parentIDs.add(targetTask.id);
    _addToPercentage(
        targetTask.id, 1, (taskToMove.childrenSum / taskToMove.childrenNumber));

    taskToMove.parentObjects.forEach((parentObj) {
      if (parentObj.userID == userID)
        parentObj.parentID = targetTask.id;
      else if (parentObj.parentID == currentParentID &&
          parentObj.parentID != Task.getRoot().id) {
        parentObj.parentID = targetTask.id;
      }
    });
    _fireStoreDataBase.collection("tasks").doc(taskToMove.id).update({
      "parentObjects": taskToMove.parentObjects.map((e) => e.toJson()).toList(),
      "parentIDs": taskToMove.parentIDs,
    });
  }

  static addTask(String taskName, Task parentTask, String userID) {
    /*var parentObjects = parentTask.parentObjects.map((parent) {
      parent.parentID = parentTask.id;
      return parent.toJson();
    });*/
    var addTaskData = Map<String, dynamic>();
    addTaskData['title'] = taskName;
    addTaskData['parentObjects'] = [Parent(parentTask.id, userID).toJson()];
    addTaskData['parentIDs'] = [parentTask.id];
    addTaskData['childrenNumber'] = 0;
    addTaskData['childrenSum'] = 0;
    addTaskData['readers'] = [userID];
    addTaskData['writers'] = [userID];
    //addTaskData['caseSearch'] = setSearchParam(taskName);
    return _fireStoreDataBase.collection('tasks').add(addTaskData);
  }

/*
  static deleteTask(String taskID) async {
    _fireStoreDataBase.collection('tasks').doc(taskID).delete();
  }*/

  static checkTask(Task task) {
    _fireStoreDataBase.collection("tasks").doc(task.id).update({
      "childrenSum": task.childrenSum,
    });
  }

  static _addToPercentage(
      String taskID, num childrenNumber, num childPercentage) {
    if (taskID != Task.getRoot().id) {
      _fireStoreDataBase.collection("tasks").doc(taskID).update({
        "childrenNumber": FieldValue.increment(childrenNumber),
        "childrenSum": FieldValue.increment(childPercentage)
      });
    }
  }

  static Future<Task> getTask(String taskID) async {
    DocumentSnapshot doc =
        await _fireStoreDataBase.collection('tasks').doc(taskID).get();
    Task task = Task.fromJson(doc.data());
    task.id = doc.id;
    return task;
  }

  /*static setSearchParam(String taskName) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < taskName.length; i++) {
      temp = temp + taskName[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }*/

  static addUser(AppUser user) async {
    if (user != null) {
      final DocumentSnapshot doc = await _fireStoreDataBase
          .collection("users")
          .doc(user.uid)
          .get();

      if (!doc.exists) {
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

  static void fromAnonToUser(AppUser oldUser, AppUser newUser) async{
    if (oldUser != null) {
         _fireStoreDataBase.collection('users').doc(oldUser.uid).update({
            "email" : newUser.email,
            "photoURL" : newUser.photoURL,
        });
    } else {
      print("the oldUser was null");
    }

  }

  static void deleteUser(AppUser user){

    if(user != null){
      _fireStoreDataBase.collection('users').doc(user.uid).delete();
      ///todo da eliminare anche le task associate
     /// _fireStoreDataBase.collection('tasks').doc(user.uid).delete();

    }
  }

  static deleteTask(Task task, String userID) {
    _fireStoreDataBase.collection("tasks").doc(task.id).update({
      "parentObjects": FieldValue.arrayRemove(
          [Parent(task.getParentID(userID), userID).toJson()]),
    }).catchError((error) => print(error));
    _fireStoreDataBase
        .collection("tasks")
        .where("parentObjects", arrayContains: Parent(task.id, userID).toJson())
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((docSnap) {
        Task child = Task.fromJson(docSnap.data());
        child.id = docSnap.id;
        deleteTask(child, userID);
      });
    });
  }

  static Future<bool> shareTaskTree( Task task, String email, String userID) async {
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
      String receivingUserID = docs.first.id;
      DocumentReference taskRef =
          _fireStoreDataBase.collection("tasks").doc(task.id);
      _shareTask(taskRef, "root", receivingUserID, userID);
      return true;
    }
    return false;
  }

  static Stream<QuerySnapshot> search(String title, String userID){
    if(title != "" && title != null){
      return _fireStoreDataBase.collection('tasks')
           .orderBy('title')
           .startAt([title])
           .endAt([title + '\uf8ff'])
           .snapshots();
    }else{
      return _fireStoreDataBase.collection('tasks').snapshots();
    }

  }



  static _shareTask(DocumentReference doc, String parentID,
      String receivingUserID, String userID) {
    doc.update({
      "parentObjects":
          FieldValue.arrayUnion([Parent(parentID, receivingUserID).toJson()]),
      "readers": [receivingUserID],
    }).catchError((error) => print(error));
    print("ok");
    _fireStoreDataBase
        .collection("tasks")
        .where("parentObjects", arrayContains: Parent(doc.id, userID).toJson())
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((docSnap) {
        _shareTask(docSnap.reference, doc.id, receivingUserID, userID);
      });
    });
  }
}
