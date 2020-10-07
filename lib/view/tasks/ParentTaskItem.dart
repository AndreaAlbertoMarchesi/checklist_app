import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ParentTaskItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Padding(
      padding: EdgeInsets.all(7),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.lightBlue[100],
          boxShadow: [
            BoxShadow(color: Colors.lightBlue[100], spreadRadius: 3),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                appState.task.title,
                style: TextStyle(
                  fontSize: 60.0,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: CircularPercentIndicator(
                radius: 35.0,
                lineWidth: 8.0,
                percent: appState.task.percentage.toDouble(),
                center: isCompleted(appState.task, appState.task.percentage.toDouble()),
                progressColor: Colors.greenAccent[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget isCompleted(Task task, num percentage){
    if((percentage*100) == 100.0){
      return Image.asset('images/completeIcon.png');
    }else
      return Text(
          (task.percentage * 100).toInt().toString() +
              "%");
  }

}
