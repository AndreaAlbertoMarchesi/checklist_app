import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'TaskItemName.dart';



class TaskItem extends StatefulWidget {
  const TaskItem(this.task, this.setSelection, [this.parent]);

  final TaskItemState parent;
  final Function setSelection;
  final Task task;

  @override
  TaskItemState createState() => TaskItemState(task);
}

class TaskItemState extends State<TaskItem> {
  TaskItemState(this.task);

  bool selected = false;
  Task task;

  @override
  Widget build(BuildContext context) {
    return _buildTiles(widget.task);
  }

  //I due widget da fare probabilmente con ereditarietà

  Widget _buildTiles(Task root) {
    if (root.children.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: _calculatePadding()),
        child: ListTile(
          title: TaskItemName(task: task),
          selected: selected,
          trailing: Checkbox(
            value: task.percentage == 1,
            onChanged: (bool value) {
              setState(() {
                if (task.percentage == 0)
                  task.percentage = 1;
                else
                  task.percentage = 0;
                if (widget.parent != null) widget.parent.refresh();
              });
            },
          ),
          onTap: () {
            widget.setSelection(this);
            setState(() {
              selected = !selected;
            });
          },
        ),
      );
    } else {
      task.updatePercentage();
      return Padding(
        padding: EdgeInsets.only(left: _calculatePadding()),
        child: ExpansionTile(
          title: Text(""),
          key: PageStorageKey<Task>(root),
          leading: TaskItemName(task: task),
          trailing: CircularPercentIndicator(
            radius: 35.0,
            lineWidth: 8.0,
            percent: task.percentage.toDouble(),
            center: new Text((task.percentage*100).toInt().toString()+"%"),
            progressColor: Colors.green,
          ),
          //Text(task.percentage.toString()),
          children: root.children.map((task) {
            return TaskItem(task, widget.setSelection, this);
          }).toList(),
          onExpansionChanged: (expanded) {
            widget.setSelection(this);
          },
        ),
      );
    }
  }

  double _calculatePadding(){
    if (widget.parent == null)
      return  0;
    else
      return 20;
  }

  void refresh() {
    setState(() {
      task.updatePercentage();
    });
    if (widget.parent != null)
      widget.parent.refresh();
  }

  void deselect() {
    setState(() {
      selected = false;
    });
  }

  void addTask() {
    setState(() {
      if (task.children.isEmpty)
        task.children = [Task()];
      else
        task.children.add(Task());
    });
  }
}