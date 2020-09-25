import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';

import 'CheckboxRow.dart';
import 'PercentageRow.dart';

class TaskItem extends StatefulWidget {
  const TaskItem(this.task, this.openTask, this.refresh, this.selectTask);

  final Task task;
  //tutte ste funzie da riordinare mettendole dentro classe tipo TaskItemFunctions
  final Function openTask;
  final Function refresh;
  final Function selectTask;

  @override
  TaskItemState createState() => TaskItemState(task);
}

class TaskItemState extends State<TaskItem> {
  TaskItemState(this.task);

  bool selected = false;
  Task task;

  @override
  Widget build(BuildContext context) {
    return _buildTiles(/*widget.task*/);
  }

  //I due widget da fare probabilmente con ereditarietà

  Widget _buildTiles() {

    return InkWell(
      child: Card(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: getCardContent(task, widget.refresh),
      ),
      onTap: () {
        widget.openTask(task);
      },
      onDoubleTap: (){
        widget.selectTask(task);
      },
    );
  }

  Widget getCardContent(Task task, Function refresh) {
    if (task.children.isEmpty)
      return CheckboxRow(task, refresh);
    else
      return PercentageRow(task);
  }
}
