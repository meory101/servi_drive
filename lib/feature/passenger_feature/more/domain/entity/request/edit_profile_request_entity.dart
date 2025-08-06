import 'dart:convert';
/// fullName : "John Doe"
/// email : "john.doe@example.com"
/// gender : "Male"
/// dateOfBirth : "1990-01-15T00:00:00.000Z"

EditProfileRequestEntity editProfileRequestEntityFromJson(String str) => EditProfileRequestEntity.fromJson(json.decode(str));
String editProfileRequestEntityToJson(EditProfileRequestEntity data) => json.encode(data.toJson());
class EditProfileRequestEntity {
  EditProfileRequestEntity({
      String? fullName, 
      String? email, 
      String? gender, 
      String? dateOfBirth,}){
    _fullName = fullName;
    _email = email;
    _gender = gender;
    _dateOfBirth = dateOfBirth;
}

  EditProfileRequestEntity.fromJson(dynamic json) {
    _fullName = json['fullName'];
    _email = json['email'];
    _gender = json['gender'];
    _dateOfBirth = json['dateOfBirth'];
  }
  String? _fullName;
  String? _email;
  String? _gender;
  String? _dateOfBirth;
EditProfileRequestEntity copyWith({  String? fullName,
  String? email,
  String? gender,
  String? dateOfBirth,
}) => EditProfileRequestEntity(  fullName: fullName ?? _fullName,
  email: email ?? _email,
  gender: gender ?? _gender,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
);
  String? get fullName => _fullName;
  String? get email => _email;
  String? get gender => _gender;
  String? get dateOfBirth => _dateOfBirth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = _fullName;
    map['email'] = _email;
    map['gender'] = _gender;
    map['dateOfBirth'] = _dateOfBirth;
    return map;
  }

}