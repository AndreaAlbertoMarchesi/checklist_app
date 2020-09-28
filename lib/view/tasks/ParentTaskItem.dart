import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ParentTaskItem extends StatelessWidget {
  ParentTaskItem(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {
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
                task.title,
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
                percent: task.percentage.toDouble(),
                center: new Text((task.percentage * 100).toInt().toString() + "%"),
                progressColor: Colors.green,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
