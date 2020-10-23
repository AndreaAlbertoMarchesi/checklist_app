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
  List<Parent> parentObjects;
  List<String> parentIDs;
  int childrenNumber;
  num childrenSum;
  String title;

  static final Task emptyRoot = Task("⌂");

  Task(this.title);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  static Task getRoot() {
    Task root = Task("⌂");
    root.id = "root";
    return root;
  }

  double getPercentage() {
    if (childrenSum == 0)
      return 0;
    else
      return (childrenSum / childrenNumber).clamp(0, 1).toDouble();
  }

  String getParentID(String userID) {
    if (parentObjects != null)
      for (var parent in parentObjects) {
        if (parent.userID == userID) return parent.parentID;
      }
    return null;
  }
}

@JsonSerializable(explicitToJson: true)
class Parent {
  Parent(this.parentID, this.userID);

  String parentID;
  String userID;

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  Map<String, dynamic> toJson() => _$ParentToJson(this);
}
