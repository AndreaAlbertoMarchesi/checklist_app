import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';

import 'CheckboxRow.dart';
import 'PercentageRow.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  TaskItem(this.task);
  final Task task;

  @override
  TaskItemState createState() => TaskItemState();
}

class TaskItemState extends State<TaskItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return InkWell(
        child: Card(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: getCardContent(widget.task, appState.updateTaskPathPercentage),
        ),
        onTap: () {
          appState.openTask(widget.task);
        },
        onDoubleTap: () {
          appState.selectTask(widget.task);
        },
      );
    }

  Widget getCardContent(Task task, Function refresh) {
    if (task.children.isEmpty)
      return CheckboxRow(task);
    else
      return PercentageRow(task);
  }
}
