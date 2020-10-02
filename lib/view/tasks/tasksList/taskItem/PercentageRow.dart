import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentageRow extends StatelessWidget {
  PercentageRow(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.lightBlueAccent[100], spreadRadius: 1),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 50),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(task.title)),
            Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: CircularPercentIndicator(
                radius: 35.0,
                lineWidth: 8.0,
                percent: task.percentage.toDouble(),
                center: new Text(
                    (task.percentage * 100).toInt().toString() +
                        "%"),
                progressColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
