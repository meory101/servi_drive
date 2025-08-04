import 'dart:convert';

import '../../../../../../core/model/user.dart';

LoginResponseEntity loginResponseEntityFromJson(String str) =>
    LoginResponseEntity.fromJson(json.decode(str));

String loginResponseEntityToJson(LoginResponseEntity data) =>
    json.encode(data.toJson());

class LoginResponseEntity {
  LoginResponseEntity({
    User? user,
    bool? isVerified,
    String? accessToken,
  }) {
    _user = user;
    _isVerified = isVerified;
    _accessToken = accessToken;
  }

  LoginResponseEntity.fromJson(dynamic json) {
    _isVerified = json['isVerified'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _accessToken = json['access_token'];
  }

  User? _user;
  String? _accessToken;
  bool?_isVerified;

  LoginResponseEntity copyWith({
    User? user,
    bool? isVerified,
    String? accessToken,
  }) =>
      LoginResponseEntity(
        user: user ?? _user,
        isVerified: isVerified ?? _isVerified,
        accessToken: accessToken ?? _accessToken,
      );

  User? get user => _user;

  String? get accessToken => _accessToken;
  bool? get isVerified => _isVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['access_token'] = _accessToken;
    return map;
  }
}
