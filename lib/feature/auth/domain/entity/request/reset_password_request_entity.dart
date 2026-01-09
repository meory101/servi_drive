import 'dart:convert';
/// phoneNumber : "+1234567890"
/// otpCode : "1234"
/// newPassword : "NewPassword123!"

ResetPasswordRequestEntity resetPasswordRequestEntityFromJson(String str) => ResetPasswordRequestEntity.fromJson(json.decode(str));
String resetPasswordRequestEntityToJson(ResetPasswordRequestEntity data) => json.encode(data.toJson());
class ResetPasswordRequestEntity {
  ResetPasswordRequestEntity({
      String? phoneNumber, 
      String? otpCode, 
      String? newPassword,}){
    _phoneNumber = phoneNumber;
    _otpCode = otpCode;
    _newPassword = newPassword;
}

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  ResetPasswordRequestEntity.fromJson(dynamic json) {
    _phoneNumber = json['phoneNumber'];
    _otpCode = json['otpCode'];
    _newPassword = json['newPassword'];
  }
  String? _phoneNumber;
  String? _otpCode;
  String? _newPassword;
ResetPasswordRequestEntity copyWith({  String? phoneNumber,
  String? otpCode,
  String? newPassword,
}) => ResetPasswordRequestEntity(  phoneNumber: phoneNumber ?? _phoneNumber,
  otpCode: otpCode ?? _otpCode,
  newPassword: newPassword ?? _newPassword,
);
  String? get phoneNumber => _phoneNumber;
  String? get otpCode => _otpCode;
  String? get newPassword => _newPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = _phoneNumber;
    map['otpCode'] = _otpCode;
    map['newPassword'] = _newPassword;
    return map;
  }

  set otpCode(String ?value) {
    _otpCode = value;
  }

  set newPassword(String? value) {
    _newPassword = value;
  }
}