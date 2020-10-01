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

  static final Task emptyRoot = Task("⌂");

  Task(this.title);

  void updatePercentage() {
    percentage = 0;
    children
        .forEach((child) => percentage += child.percentage / children.length);
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  ///per cambiare ordine sul model e non solo sulla view
  void handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final element = this.children.removeAt(oldIndex);
    this.children.insert(newIndex, element);
  }

}
