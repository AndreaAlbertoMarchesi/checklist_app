import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:checklist_app/view/Settings/DarkThemeState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckboxRow extends StatelessWidget {
  CheckboxRow(this.task);

  final Task task;
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final darkState = context.watch<DarkThemeState>();

    Color getColor(){
      if(darkState.darkTheme){
        return Colors.blueGrey;
      }else{
        return Colors.lightBlue[50];
      }
    }



    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: getColor(),
        boxShadow: [
          BoxShadow(color: Colors.lightBlue[100], spreadRadius: 3),
        ],
      ),
      constraints: BoxConstraints(maxHeight: 50),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              task.title,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Expanded(child: Container()),
          Checkbox(
            value: task.getPercentage() == 1,
            onChanged: (bool value) {
                appState.checkTask(task);
            },
          ),
        ],
      ),
    );
  }
}
