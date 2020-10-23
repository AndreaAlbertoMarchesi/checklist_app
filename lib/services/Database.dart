import 'package:checklist_app/model/AppUser.dart';
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
    addTaskData['caseSearch'] = setSearchParam(taskName);
    return _fireStoreDataBase.collection('tasks').add(addTaskData);
  }
  static setSearchParam(String taskName){
    List<String> caseSearchList = List();
    String temp = "";
    for(int i = 0 ; i < taskName.length; i++){
      temp = temp + taskName[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  static Future<Task> getTask(String taskID) async {
    DocumentSnapshot doc =
        await _fireStoreDataBase.collection('tasks').doc(taskID).get();
    Task task = Task.fromJson(doc.data());
    task.id = doc.id;
    return task;
  }

  static addUser(AppUser user) async{

    ///todo controlla che non ci sia già un utente con lo stesso nome nel database
    if( user != null ){
      final QuerySnapshot querySnapshot = await _fireStoreDataBase.collection("users").where("userID" , isEqualTo: user.uid).get();
      final List<DocumentSnapshot> docs = querySnapshot.docs;

      if(docs.length == 0){
         _fireStoreDataBase.collection('users').doc(user.uid).set({
           "email" : user.email,
           "photoURL" : user.photoURL,
         });
      }else{
        print("the user is already added");
      }

    }else{
      print("the user from auth is null");
    }

  }


  static Future<bool> share(Task task, String email) async{
    //create a new document of a task with id of the new user and a collection of users data?
    final QuerySnapshot querySnapshot = await _fireStoreDataBase.collection("users").where("email" , isEqualTo: email).get();
    final List<DocumentSnapshot> docs = querySnapshot.docs;
    if( docs != null){
      print("user trovato");
      docs.forEach((element) {print(element.data().toString());});
      ///todo associare una task a uno user
      return true;
    }
    return false;
  }

}
