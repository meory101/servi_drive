import 'dart:convert';


RegisterRequestEntity registerRequestEntityFromJson(String str) => RegisterRequestEntity.fromJson(json.decode(str));
String registerRequestEntityToJson(RegisterRequestEntity data) => json.encode(data.toJson());
class RegisterRequestEntity {
  RegisterRequestEntity({
      String? username, 
      String? phoneNumber, 
      String? fullName, 
      String? password, 
      String? email, 
      String? gender, 
      String? role,}){
    _username = username;
    _phoneNumber = phoneNumber;
    _fullName = fullName;
    _password = password;
    _email = email;
    _gender = gender;
    _role = role;
}

  set username(String? value) {
    _username = value;
  }

  RegisterRequestEntity.fromJson(dynamic json) {
    _username = json['username'];
    _phoneNumber = json['phoneNumber'];
    _fullName = json['fullName'];
    _password = json['password'];
    _email = json['email'];
    _gender = json['gender'];
    _role = json['role'];
  }
  String? _username;
  String? _phoneNumber;
  String? _fullName;
  String? _password;
  String? _email;
  String? _gender;
  String? _role;
RegisterRequestEntity copyWith({  String? username,
  String? phoneNumber,
  String? fullName,
  String? password,
  String? email,
  String? gender,
  String? role,
}) => RegisterRequestEntity(  username: username ?? _username,
  phoneNumber: phoneNumber ?? _phoneNumber,
  fullName: fullName ?? _fullName,
  password: password ?? _password,
  email: email ?? _email,
  gender: gender ?? _gender,
  role: role ?? _role,
);
  String? get username => _username;
  String? get phoneNumber => _phoneNumber;
  String? get fullName => _fullName;
  String? get password => _password;
  String? get email => _email;
  String? get gender => _gender;
  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['phoneNumber'] = _phoneNumber;
    map['fullName'] = _fullName;
    map['password'] = _password;
    map['email'] = _email;
    map['gender'] = _gender;
    map['role'] = _role;
    return map;
  }

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  set fullName(String? value) {
    _fullName = value;
  }

  set password(String? value) {
    _password = value;
  }

  set email(String? value) {
    _email = value;
  }

  set gender(String? value) {
    _gender = value;
  }

  set role(String? value) {
    _role = value;
  }
}