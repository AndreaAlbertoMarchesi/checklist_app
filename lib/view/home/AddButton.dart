import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddDialog.dart';

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    if(appState.selectedTask == null)
      return FloatingActionButton(
        onPressed: () {
          openAddDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      );
    else
      return FloatingActionButton(
        onPressed: appState.moveTask,
        child: Icon(Icons.drive_file_move),
        backgroundColor: Colors.green,
      );
  }

  void openAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddDialog();
      },
    );
  }
}