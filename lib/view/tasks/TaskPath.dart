import 'package:checklist_app/model/Task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TaskPath extends StatefulWidget {
  TaskPath(this.taskPath, this.backToTask);


  final List<Task> taskPath;
  final Function backToTask;

  @override
  _TaskPathState createState() => _TaskPathState(taskPath);
}

class _TaskPathState extends State<TaskPath> {

  _TaskPathState(this.taskPath);

  List<Task> taskPath;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.taskPath.map((task) {
          return InkWell(
            child: Text(
              " -->" + task.title,
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {widget.backToTask(task);},
          );
        }).toList(),
      ),
    );
  }
}
