import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  AddButton(this.addEntry);

  final Function addEntry;


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: addEntry,
      child: Icon(Icons.add),
      backgroundColor: Colors.green,
    );
  }
}