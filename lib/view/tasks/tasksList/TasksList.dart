import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';

import 'taskItem/TaskItem.dart';

class TasksList extends StatelessWidget {
  TasksList(this.task, this.openTask, this.refresh, this.selectTask, this.handleReorder);

  final Task task;
  //tutte ste funzie da riordinare mettendole dentro classe tipo TaskItemFunctions
  final Function openTask;
  final Function refresh;
  final Function selectTask;
  final Function handleReorder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ReorderableListView(
      onReorder: handleReorder,
      children: task.children.map((task) {
        return Container(
            key: PageStorageKey(task),
            child: TaskItem(task, openTask, refresh, selectTask));
      }).toList(),
    ));
  }
}
