import 'package:checklist_app/model/AppState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TaskPath extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    if (appState.taskPath.length > 1) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
        children: appState.taskPath.map((task) {
          return InkWell(
            child: Row(children: [
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "⧐",
                    style: TextStyle(fontSize: 30),
                  )),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(
                      color: Colors.blue[200],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    task.title,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ]),
            onTap: () {
              appState.backToTask(task);
            },
          );
        }).toList(),
      ),
      );
    } else {
      return Text("Home");
    }
  }
}
