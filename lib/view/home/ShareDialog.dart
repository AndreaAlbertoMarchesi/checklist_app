
import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:provider/provider.dart';

class ShareDialog extends StatelessWidget {

  final Task task;


  ShareDialog(this.task);

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    final appState = context.watch<AppState>();
    String email = '';
    String comment = '';

    Widget doneButton(context) {
      return FlatButton(
        child: Text("Back"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }

    Widget shareButton(context) {
      return FlatButton(
        child: Text("Share"),
        onPressed: () async{
          if (_formKey.currentState.validate()) {
            await appState.share(task, email , comment);
            Navigator.of(context).pop();
          } else {
            Vibration.vibrate(duration: 100);
          }
        },
      );
    }

    return AlertDialog(
      title: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter email",
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan[100], width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan[400], width: 2.0),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Enter a valid email' : null,
                onChanged: (val) {
                  email = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter comment",
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan[100], width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan[400], width: 2.0),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Enter a not empty comment' : null,
                onChanged: (val) {
                  comment = val;
                },
              ),
            ),
          ],
        )
      ),
      actions: [
        doneButton(context),
        shareButton(context),
      ],
    );
  }
}
