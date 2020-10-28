import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:checklist_app/view/Settings/DarkThemeState.dart';
import 'package:checklist_app/services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ParentTaskItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final darkState = context.watch<DarkThemeState>();

    Color getColor() {
      if (darkState.darkTheme) {
        return Colors.blueGrey;
      } else {
        return Colors.lightBlue[50];
      }
    }

    return Padding(
      padding: EdgeInsets.all(7),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getColor(),
          boxShadow: [
            BoxShadow(color: getColor(), spreadRadius: 3),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                appState.parentTask.title,
                style: TextStyle(
                  fontSize: 60.0,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Expanded(child: Container()),
            if (appState.parentTask.id != Task.getRoot().id)
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 8.0,
                  percent: appState.parentTask.getPercentage(),
                  animation: true,
                  animateFromLastPercent: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: isCompleted(appState.parentTask),
                  linearGradient: LinearGradient(colors: [
                    Colors.greenAccent[400],
                    Colors.red,
                  ]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget isCompleted(Task task) {
    if ((task.getPercentage() * 100) == 100.0) {
      return Icon(
        IconData(0xf10d, fontFamily: 'MaterialIcons'),
        color: Colors.greenAccent[700],
      );
    } else
      return Text((task.getPercentage() * 100).toInt().toString() + "%");
  }
}
