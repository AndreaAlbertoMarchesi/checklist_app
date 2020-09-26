import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';

import 'taskItem/TaskItem.dart';

class TasksList extends StatelessWidget {
  TasksList(this.task, this.openTask, this.updatePercentage, this.selectTask);

  final Task task;
  //tutte ste funzie da riordinare mettendole dentro classe tipo TaskItemFunctions
  final Function openTask;
  final Function updatePercentage;
  final Function selectTask;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {},
      children: task.children.map((task) {
        return Container(
            key: PageStorageKey(task),
            child: TaskItem(task, openTask, updatePercentage, selectTask));
      }).toList(),
    ));
  }
}
