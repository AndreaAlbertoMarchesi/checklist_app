import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';

class TaskItemName extends StatefulWidget {
  final Task task;

  const TaskItemName({this.task});

  @override
  _TaskItemNameState createState() => _TaskItemNameState(task);
}

class _TaskItemNameState extends State<TaskItemName> {
  _TaskItemNameState(this.task);

  bool isEditing = false;
  Task task;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(task.title== null)
      isEditing = true;
    if (isEditing) {
      return TextField(
        key: PageStorageKey('tit'),
        controller: textController,
        decoration: InputDecoration(
          hintText: "insert name",
        ),
        onEditingComplete: () {
          setState(() {
            isEditing = false;
            task.title = textController.text;
          });
        },
      );
    } else {
      return InkWell(
        child: Text(
          task.title,
          textAlign: TextAlign.left,
        ),
        onLongPress: () => setState(() {
          isEditing = true;
        }),
      );
    }
  }
}
