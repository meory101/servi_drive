import 'dart:convert';


LoginRequestEntity loginRequestEntityFromJson(String str) => LoginRequestEntity.fromJson(json.decode(str));
String loginRequestEntityToJson(LoginRequestEntity data) => json.encode(data.toJson());
class LoginRequestEntity {
  LoginRequestEntity({
      String? username, 
      String? password,}){
    _username = username;
    _password = password;
}

  LoginRequestEntity.fromJson(dynamic json) {
    _username = json['username'];
    _password = json['password'];
  }
  String? _username;
  String? _password;
LoginRequestEntity copyWith({  String? username,
  String? password,
}) => LoginRequestEntity(  username: username ?? _username,
  password: password ?? _password,
);
  String? get username => _username;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['password'] = _password;
    return map;
  }

}