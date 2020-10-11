import 'package:checklist_app/model/AppState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'AddDialog.dart';

class AddButton extends StatelessWidget {
  static final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    if (appState.selectedListOfTasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 80,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      openAddDialog(context);
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Colors.greenAccent[400],
                  ),
                ),
              ],
            )),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 80,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: appState.moveTask,
                    child: Icon(Icons.drive_file_move),
                    backgroundColor: Colors.greenAccent[400],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    onPressed: appState.unDoSelection,
                    child: Icon(Icons.undo),
                    backgroundColor: Colors.grey,
                  ),
                ),
              ],
            )),
      );
    }
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
