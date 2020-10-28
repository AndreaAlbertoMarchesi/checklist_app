import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:checklist_app/view/home/ShareDialog.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:vibration/vibration.dart';
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

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return InkWell(
        child: SwipeTo(
          child: Card(
            color: getColor(appState.selectedListOfTasks),
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: getCardContent(widget.task),
          ),
          onLeftSwipe: (){
            print('Callback from Swipe To Left');
            Vibration.vibrate(duration: 100);
            deleteDialog(appState);
          },
          onRightSwipe: (){
            shareDialog();
          },
          iconOnLeftSwipe: Icons.delete_outline,
          iconColor: Colors.deepPurple[600],
          iconOnRightSwipe: Icons.share_outlined,
        ),
        onTap: () {
          appState.openTask(widget.task);
        },
        onDoubleTap: () {
          Vibration.vibrate(duration: 100);
          appState.selectTask(widget.task);
        },
      );
    }

  Color getColor(List<Task> tasks) {
    if (tasks.contains(widget.task)) {
      return Colors.lightGreenAccent[100];
    } else {
      return Colors.white;
    }
  }

  Widget getCardContent(Task task) {
    if (task.childrenNumber==0)
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
              appState.deleteTask(widget.task);
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
  void shareDialog(){
    showDialog(
      context: context,
      child: ShareDialog(widget.task),
    );
  }
}
