import 'dart:convert';

import '../../../../../../core/model/user.dart';


ProfileResponseEntity profileResponseEntityFromJson(String str) => ProfileResponseEntity.fromJson(json.decode(str));
String profileResponseEntityToJson(ProfileResponseEntity data) => json.encode(data.toJson());
class ProfileResponseEntity {
  ProfileResponseEntity({
      User? user, 
      String? message,}){
    _user = user;
    _message = message;
}

  ProfileResponseEntity.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _message = json['message'];
  }
  User? _user;
  String? _message;
ProfileResponseEntity copyWith({  User? user,
  String? message,
}) => ProfileResponseEntity(  user: user ?? _user,
  message: message ?? _message,
);
  User? get user => _user;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}
