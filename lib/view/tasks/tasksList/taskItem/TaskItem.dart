import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'CheckboxRow.dart';
import 'PercentageRow.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  TaskItem(this.task);

  final Task task;

  @override
  TaskItemState createState() => TaskItemState();
}

class TaskItemState extends State<TaskItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return InkWell(
        child: SwipeTo(
          swipeDirection: SwipeDirection.swipeToLeft,
          endOffset: Offset(-0.6, 0.0),
          animationDuration: const Duration(milliseconds: 300),
          iconData: Icons.delete_outline,
          callBack: () {
            print('Callback from Swipe To Left');
            deleteDialog(appState);
          },
          child: Card(
            color: getColor(),
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: getCardContent(widget.task, appState.updateTaskPathPercentage),
          ),
        ),
        onTap: () {
          appState.openTask(widget.task);
        },
        onDoubleTap: () {
          setState(() {
            selected = true;
          });
          appState.selectTask(widget.task);
        },
      );
    }

  Color getColor() {
    if (selected) {
      return Colors.lightGreenAccent[100];
    } else {
      return Colors.white;
    }
  }

  Widget getCardContent(Task task, Function refresh) {
    if (task.children.isEmpty)
      return CheckboxRow(task);
    else
      return PercentageRow(task);
  }

  void deleteDialog(appState){
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Item Selected"),
        content: Text("Do you want to delete it?"),
        actions: [
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              appState.deleteTask(widget.task, appState.taskPath.last);
              Navigator.of(context).pop();
            },
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
  }
}
