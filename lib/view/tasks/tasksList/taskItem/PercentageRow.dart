import 'package:checklist_app/model/Task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentageRow extends StatelessWidget {
  PercentageRow(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {

    return Container(
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
                center: isCompleted(task.percentage.toDouble()),
                progressColor: Colors.greenAccent[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget isCompleted(num percentage){
    if((percentage*100) == 100.0){
      return Image.asset('images/completeIcon.png');
    }else
      return Text(
          (task.percentage * 100).toInt().toString() +
              "%");
  }
}
