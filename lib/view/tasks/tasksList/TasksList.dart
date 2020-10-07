import 'package:checklist_app/model/AppState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'taskItem/TaskItem.dart';

class TasksList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Expanded(
        child: ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        appState.task.handleReorder(oldIndex, newIndex);
      },
      children: appState.task.children.map((task) {
        return Container(
            key: PageStorageKey(task),
            child: TaskItem(task));
      }).toList(),
    ));
  }
}
