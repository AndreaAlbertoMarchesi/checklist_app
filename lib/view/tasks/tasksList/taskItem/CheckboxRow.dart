import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckboxRow extends StatelessWidget {
  CheckboxRow(this.task);

  final Task task;
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

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

                appState.updateTaskPathPercentage();
            },
          ),
        ],
      ),
    );
  }
}
