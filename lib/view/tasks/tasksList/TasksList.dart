import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:checklist_app/services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'taskItem/TaskItem.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Expanded(
        child: ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {},
      children: getChildren(appState.tasks),
    ));
  }

  List<Widget> getChildren(List<Task> tasks) {
    if (tasks != null) {
      return tasks.map((task) {
        return Container(key: PageStorageKey(task), child: TaskItem(task));
      }).toList();
    } else {
      print("empty children");
      return [];
    }
  }
}
