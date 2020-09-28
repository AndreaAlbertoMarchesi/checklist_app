import 'package:checklist_app/model/Task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskPath extends StatefulWidget {
  TaskPath(this.taskPath, this.backToTask);

  final List<Task> taskPath;
  final Function backToTask;

  @override
  _TaskPathState createState() => _TaskPathState(taskPath);
}

class _TaskPathState extends State<TaskPath> {
  _TaskPathState(this.taskPath);

  List<Task> taskPath;

  @override
  Widget build(BuildContext context) {
    if(taskPath.length > 1) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: PopupMenuButton(
            elevation: 3.2,
            icon: Icon(Icons.arrow_back),
            onSelected : (task){
              widget.backToTask(task);
            },
            onCanceled: () {
              print('You have not chossed anything');
            },
            tooltip: 'Path',
            itemBuilder: (BuildContext context) {
              return taskPath.map((Task choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList().sublist(0, taskPath.length - 1);
            }
        ),
        ///alternativa con il path stampato interamente sulla appbar
        /* Row(
        children: widget.taskPath.map((task) {
          return InkWell(
            child: Row(children: [
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "⧐",
                    style: TextStyle(fontSize: 30),
                  )),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(
                      color: Colors.blue[200],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    task.title,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ]),
            onTap: () {
              widget.backToTask(task);
            },
          );
        }).toList(),
      ),*/);
    }else{
      return Text("Home");
    }

  }
}
