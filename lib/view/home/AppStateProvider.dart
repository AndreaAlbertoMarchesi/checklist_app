import 'package:checklist_app/controller/Storage.dart';
import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/view/home/AddButton.dart';
import 'package:checklist_app/view/tasks/ParentTaskItem.dart';
import 'package:checklist_app/view/tasks/TaskPath.dart';
import 'package:checklist_app/view/tasks/tasksList/TasksList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

class AppStateProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AppState(),
        child: Home());
  }
}
