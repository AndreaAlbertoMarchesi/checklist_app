import 'package:json_annotation/json_annotation.dart';

part 'Task.g.dart';

/*
visit this link for automatic json serialization of a class:
https://flutter.dev/docs/development/data-and-backend/json

flutter pub run build_runner build --delete-conflicting-outputs
 */

@JsonSerializable(explicitToJson: true)
class Task {
  String id;
  List<Parent> parents;
  String title;
  num percentage = 0;

  static final Task emptyRoot = Task("⌂");

  Task(this.title);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  String getParent(String userID) {
    if(parents!=null)
      for(var parent in parents) {
        if (parent.userID == userID)
          return parent.parent;
      }
    return null;
  }
}

@JsonSerializable(explicitToJson: true)
class Parent {
  Parent(this.userID, this.parent);

  String userID;
  String parent;

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  Map<String, dynamic> toJson() => _$ParentToJson(this);
}
