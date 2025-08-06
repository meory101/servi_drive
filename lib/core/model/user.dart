import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
    String? phoneNumber,
    String? username,
    String? fullName,
    String? gender,
    String? email,
    String? image,
    String? role,
    num? tickets,
    bool? isPhoneVerified,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,}){
    _phoneNumber = phoneNumber;
    _username = username;
    _fullName = fullName;
    _gender = gender;
    _email = email;
    _role = role;
    _tickets = tickets;
    _isPhoneVerified = isPhoneVerified;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _image = image;
    _v = v;
  }

  User.fromJson(dynamic json) {
    _phoneNumber = json['phoneNumber'];
    _username = json['username'];
    _fullName = json['fullName'];
    _gender = json['gender'];
    _image = json['image'];
    _email = json['email'];
    _role = json['role'];
    _tickets = json['tickets'];
    _isPhoneVerified = json['isPhoneVerified'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _phoneNumber;
  String? _image;
  String? _username;
  String? _fullName;
  String? _gender;
  String? _email;
  String? _role;
  num? _tickets;
  bool? _isPhoneVerified;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  User copyWith({  String? phoneNumber,
    String? username,
    String? image,
    String? fullName,
    String? gender,
    String? email,
    String? role,
    num? tickets,
    bool? isPhoneVerified,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) => User(  phoneNumber: phoneNumber ?? _phoneNumber,
    username: username ?? _username,
    fullName: fullName ?? _fullName,
    gender: gender ?? _gender,
    email: email ?? _email,
    image: image?? _image,
    role: role ?? _role,
    tickets: tickets ?? _tickets,
    isPhoneVerified: isPhoneVerified ?? _isPhoneVerified,
    id: id ?? _id,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    v: v ?? _v,
  );
  String? get phoneNumber => _phoneNumber;
  String? get image => _image;
  String? get username => _username;
  String? get fullName => _fullName;
  String? get gender => _gender;
  String? get email => _email;
  String? get role => _role;
  num? get tickets => _tickets;
  bool? get isPhoneVerified => _isPhoneVerified;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = _phoneNumber;
    map['username'] = _username;
    map['fullName'] = _fullName;
    map['gender'] = _gender;
    map['email'] = _email;
    map['role'] = _role;
    map['tickets'] = _tickets;
    map['isPhoneVerified'] = _isPhoneVerified;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}