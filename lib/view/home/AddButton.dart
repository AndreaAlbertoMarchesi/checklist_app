import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';

import 'AddDialog.dart';

class AddButton extends StatelessWidget {
  AddButton(this.selectedTask, this.addTask, this.moveTask);


  final Task selectedTask;
  final Function addTask;
  final Function moveTask;


  @override
  Widget build(BuildContext context) {
    if(selectedTask == null)
      return FloatingActionButton(
        onPressed: () {
          openAddDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      );
    else
      return FloatingActionButton(
        onPressed: moveTask,
        child: Icon(Icons.drive_file_move),
        backgroundColor: Colors.green,
      );
  }

  void openAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddDialog(addTask);
      },
    );
  }
}