import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class AddDialog extends StatelessWidget {
  AddDialog(this.addTask);

  final Function addTask;

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget doneButton = FlatButton(
      child: Text("Back"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    ///ho usato la vibrazione come errore
    Widget addButton = FlatButton(
      child: Text("Add"),
      onPressed: () {
        if (textController.text != "") {
          addTask(textController.text);
          Navigator.of(context).pop();
        } else {
          Vibration.vibrate(duration: 100);
        }

      },
    );

    ///volevo aggiungere un messaggio di errore per distinguere i casi ma non sono riuscita
    ///l'unica cosa che mi è venuta pensata è farlo diventare statefull
    InputDecoration isWrong(){
      if(textController.text == ""){
        return InputDecoration(
          hintText: "Enter a task name" ,
        );
      }else{
        return InputDecoration(
          hintText: "Enter a task name"
        );
      }

    }

    return AlertDialog(
      title: Text("Add tasks"),
      content: TextField(
        controller: textController,
        decoration: isWrong(),
      ),
      actions: [
        doneButton,
        addButton,
      ],
    );
  }
}
