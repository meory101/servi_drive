import 'dart:convert';


VerifyOtpRequestEntity verifyOtpRequestEntityFromJson(String str) => VerifyOtpRequestEntity.fromJson(json.decode(str));
String verifyOtpRequestEntityToJson(VerifyOtpRequestEntity data) => json.encode(data.toJson());
class VerifyOtpRequestEntity {
  VerifyOtpRequestEntity({
      String? phoneNumber, 
      String? otpCode,}){
    _phoneNumber = phoneNumber;
    _otpCode = otpCode;
}

  VerifyOtpRequestEntity.fromJson(dynamic json) {
    _phoneNumber = json['phoneNumber'];
    _otpCode = json['otpCode'];
  }
  String? _phoneNumber;
  String? _otpCode;
VerifyOtpRequestEntity copyWith({  String? phoneNumber,
  String? otpCode,
}) => VerifyOtpRequestEntity(  phoneNumber: phoneNumber ?? _phoneNumber,
  otpCode: otpCode ?? _otpCode,
);
  String? get phoneNumber => _phoneNumber;
  String? get otpCode => _otpCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = _phoneNumber;
    map['otpCode'] = _otpCode;
    return map;
  }

}