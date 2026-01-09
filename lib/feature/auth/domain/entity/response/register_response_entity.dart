import 'dart:convert';

import '../../../../../../core/model/user.dart';

RegisterResponseEntity registerResponseEntityFromJson(String str) => RegisterResponseEntity.fromJson(json.decode(str));
String registerResponseEntityToJson(RegisterResponseEntity data) => json.encode(data.toJson());
class RegisterResponseEntity {
  RegisterResponseEntity({
      User? user, 
      String? accessToken,}){
    _user = user;
    _accessToken = accessToken;
}

  RegisterResponseEntity.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _accessToken = json['access_token'];
  }
  User? _user;
  String? _accessToken;
RegisterResponseEntity copyWith({  User? user,
  String? accessToken,
}) => RegisterResponseEntity(  user: user ?? _user,
  accessToken: accessToken ?? _accessToken,
);
  User? get user => _user;
  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['access_token'] = _accessToken;
    return map;
  }

}


