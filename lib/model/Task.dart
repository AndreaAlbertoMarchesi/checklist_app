import 'package:json_annotation/json_annotation.dart';

part 'Task.g.dart';

/*
visit this link for automatic json serialization of a class:
https://flutter.dev/docs/development/data-and-backend/json
 */

@JsonSerializable(explicitToJson: true)
class Task {
  String title;
  List<Task> children = List<Task>();
  num percentage = 0;

  static final Task emptyRoot = Task("root");

  Task(this.title,); //[this.children = const <Task>[]]);

  void updatePercentage() {
    percentage = 0;
    children
        .forEach((child) => percentage += child.percentage / children.length);
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
