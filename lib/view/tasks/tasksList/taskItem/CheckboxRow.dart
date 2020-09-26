import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';

class CheckboxRow extends StatelessWidget {
  CheckboxRow(this.task, this.updatePercentage);

  final Task task;
  final Function updatePercentage;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 50),
      child: Row(
        children: [
          Text(task.title),
          Expanded(child: Container()),
          Checkbox(
            value: task.percentage == 1,
            onChanged: (bool value) {
                if (task.percentage == 0)
                  task.percentage = 1;
                else
                  task.percentage = 0;

                updatePercentage();
            },
          ),
        ],
      ),
    );
  }
}
