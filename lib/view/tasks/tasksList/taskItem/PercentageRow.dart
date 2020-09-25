import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';



class PercentageRow extends StatelessWidget {
  PercentageRow(this.task);

  final Task task;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 50),
      child: Row(
        children: [
          Text(task.title),
          Expanded(child: Container()),
          CircularPercentIndicator(
            radius: 35.0,
            lineWidth: 8.0,
            percent: task.percentage.toDouble(),
            center: new Text((task.percentage * 100).toInt().toString() + "%"),
            progressColor: Colors.green,
          ),
        ],
      ),
    );
  }
}