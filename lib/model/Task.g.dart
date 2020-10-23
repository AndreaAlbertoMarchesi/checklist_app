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
    ..parentObjects = (json['parentObjects'] as List)
        ?.map((e) =>
            e == null ? null : Parent.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..parentIDs = (json['parentIDs'] as List)?.map((e) => e as String)?.toList()
    ..childrenNumber = json['childrenNumber'] as int
    ..childrenSum = json['childrenSum'] as num;
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'parentObjects':
          instance.parentObjects?.map((e) => e?.toJson())?.toList(),
      'parentIDs': instance.parentIDs,
      'childrenNumber': instance.childrenNumber,
      'childrenSum': instance.childrenSum,
      'title': instance.title,
    };

Parent _$ParentFromJson(Map<String, dynamic> json) {
  return Parent(
    json['parentID'] as String,
    json['userID'] as String,
  );
}

Map<String, dynamic> _$ParentToJson(Parent instance) => <String, dynamic>{
      'parentID': instance.parentID,
      'userID': instance.userID,
    };
