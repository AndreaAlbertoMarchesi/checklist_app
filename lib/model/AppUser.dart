import 'package:json_annotation/json_annotation.dart';

part 'AppUser.g.dart';

@JsonSerializable(explicitToJson: true)
class AppUser {

  String email;
  String uid;
  String photoURL;

  AppUser({this.email, this.uid, this.photoURL});


  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}



