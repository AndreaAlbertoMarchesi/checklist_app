// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    json['title'] as String,
  )
    ..id = json['id'] as String
    ..parents = (json['parents'] as List)
        ?.map((e) =>
            e == null ? null : Parent.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..percentage = json['percentage'] as num;
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'parents': instance.parents?.map((e) => e?.toJson())?.toList(),
      'title': instance.title,
      'percentage': instance.percentage,
    };

Parent _$ParentFromJson(Map<String, dynamic> json) {
  return Parent(
    json['userID'] as String,
    json['parent'] as String,
  );
}

Map<String, dynamic> _$ParentToJson(Parent instance) => <String, dynamic>{
      'userID': instance.userID,
      'parent': instance.parent,
    };
