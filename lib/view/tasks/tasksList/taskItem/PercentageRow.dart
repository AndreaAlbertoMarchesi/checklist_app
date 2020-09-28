import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:swipe_to/swipe_to.dart';

class PercentageRow extends StatelessWidget {
  PercentageRow(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      swipeDirection: SwipeDirection.swipeToLeft,
      endOffset: Offset(-0.6, 0.0),
      animationDuration: const Duration(milliseconds: 300),
      iconData: Icons.delete_outline,
      callBack: () {
        print('Callback from Swipe To Left');
        return showDialog(
          context: context,
          child: AlertDialog(
            title: Text("Item Selected"),
            content: Text("Do you want to delete it?"),
            actions: [
              FlatButton(
                child: Text("Yes"),
                onPressed: () {},
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
      child: Container(
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
                      (task.percentage * 100).toInt().toString() + "%"),
                  progressColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
