import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  AddDialog(this.addTask);

  final Function addTask;

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Widget doneButton = FlatButton(
      child: Text("Done"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    Widget addButton = FlatButton(
      child: Text("Add"),
      onPressed:  () {
        if(textController.text !="")
          addTask(textController.text);
        //else
          // fare toast message
        },
    );

    return AlertDialog(
      title: Text("add tasks"),
      content: TextField(
        controller: textController,
      ),
      actions: [
        doneButton,
        addButton,
      ],
    );
  }
}
