// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return AppUser(
    email: json['email'] as String,
    uid: json['uid'] as String,
    photoURL: json['photoURL'] as String,
    isAnon: json['isAnon'] as bool,
  );
}

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'email': instance.email,
      'uid': instance.uid,
      'photoURL': instance.photoURL,
      'isAnon': instance.isAnon,
    };
