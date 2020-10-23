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
                radius: 40.0,
                lineWidth: 8.0,
                percent: task.getPercentage(),
                animation: true,
                animateFromLastPercent: true,
                circularStrokeCap: CircularStrokeCap.round,
                center: isCompleted(task.getPercentage().toDouble()),
                linearGradient: LinearGradient(
                    colors: [
                      Colors.greenAccent[400],
                      Colors.red,
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget isCompleted(num percentage){
    if((percentage*100) == 100.0){
      return Icon(
        IconData(0xe0de, fontFamily: 'MaterialIcons'),
        color: Colors.greenAccent[700],
      );
    }else
      return Text(
          (task.getPercentage() * 100).toInt().toString() + "%");
  }
}
