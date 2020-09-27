import 'package:checklist_app/model/Task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

class CheckboxRow extends StatelessWidget {
  CheckboxRow(this.task, this.refreshParent);

  final Task task;
  final Function refreshParent;

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      swipeDirection: SwipeDirection.swipeToLeft,
      endOffset: Offset(-0.6, 0.0),
      animationDuration: const Duration(milliseconds: 300 ),
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
                //da fare le funzioni per eliminare dalla lista
                onPressed: (){},
              ),
              FlatButton(
                child: Text("No"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 50),
        child: Row(
          children: [

            Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(task.title)
            ),
            Expanded(child: Container()),
            Checkbox(
              value: task.percentage == 1,
              onChanged: (bool value) {
                if (task.percentage == 0)
                  task.percentage = 1;
                else
                  task.percentage = 0;

                refreshParent();
              },
            ),
          ],
        ),
      ),
    );
  }
}
