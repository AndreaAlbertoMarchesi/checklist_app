import 'package:checklist_app/controller/Search.dart';
import 'package:checklist_app/controller/Storage.dart';
import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/view/Settings/DarkThemeState.dart';
import 'package:checklist_app/view/Settings/Styles.dart';
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

  DarkThemeState darkThemeState = new DarkThemeState();

  @override
  void initState() {
    super.initState();
    darkThemeState.getDarkTheme();
  }


  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final darkState = context.watch<DarkThemeState>();

    return MaterialApp(
      theme: Styles.themeData(darkState.darkTheme, context),
      home: WillPopScope(
        onWillPop: () async {
          appState.backToPreviousTask();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Builder(
                builder:(context) => IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){
                      showSearch(context: context, delegate: Search());
                    }
                ),
              ),
              Builder(
                builder:(context) => IconButton(
                    icon: Icon(Icons.notifications_active_outlined),
                    onPressed: (){

                    }
                ),
              ),
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
          //floatingActionButton: AddButton(),
          bottomNavigationBar: AddButton(),
        ),
      ),
    );
  }


  Stream getStream(){

  }
}
