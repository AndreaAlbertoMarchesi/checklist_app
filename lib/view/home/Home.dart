import 'package:checklist_app/controller/Storage.dart';
import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/view/home/AddButton.dart';
import 'package:checklist_app/view/home/SideMenu.dart';
import 'package:checklist_app/view/tasks/ParentTaskItem.dart';
import 'package:checklist_app/view/tasks/TaskPath.dart';
import 'package:checklist_app/view/tasks/tasksList/TasksList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final Storage storage = Storage();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          appState.backToPreviousTask();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){

                  }
              )
            ],
          ),
          body: Column(
            children: [
              TaskPath(),
              ParentTaskItem(),
              TasksList(),
            ],
          ),
          drawer: SideMenu(),
          floatingActionButton: AddButton(),
        ),
      ),
    );
  }


}
