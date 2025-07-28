import 'dart:convert';
/// phoneNumber : "+1234567890"

ResendOtpRequestEntity resendOtpRequestEntityFromJson(String str) => ResendOtpRequestEntity.fromJson(json.decode(str));
String resendOtpRequestEntityToJson(ResendOtpRequestEntity data) => json.encode(data.toJson());
class ResendOtpRequestEntity {
  ResendOtpRequestEntity({
      String? phoneNumber,}){
    _phoneNumber = phoneNumber;
}

  ResendOtpRequestEntity.fromJson(dynamic json) {
    _phoneNumber = json['phoneNumber'];
  }
  String? _phoneNumber;
ResendOtpRequestEntity copyWith({  String? phoneNumber,
}) => ResendOtpRequestEntity(  phoneNumber: phoneNumber ?? _phoneNumber,
);
  String? get phoneNumber => _phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = _phoneNumber;
    return map;
  }

}