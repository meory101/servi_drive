import 'dart:convert';
/// phoneNumber : "+1234567890"

ForgotPasswordRequestEntity forgotPasswordRequestEntityFromJson(String str) => ForgotPasswordRequestEntity.fromJson(json.decode(str));
String forgotPasswordRequestEntityToJson(ForgotPasswordRequestEntity data) => json.encode(data.toJson());
class ForgotPasswordRequestEntity {
  ForgotPasswordRequestEntity({
      String? phoneNumber,}){
    _phoneNumber = phoneNumber;
}

  ForgotPasswordRequestEntity.fromJson(dynamic json) {
    _phoneNumber = json['phoneNumber'];
  }
  String? _phoneNumber;
ForgotPasswordRequestEntity copyWith({  String? phoneNumber,
}) => ForgotPasswordRequestEntity(  phoneNumber: phoneNumber ?? _phoneNumber,
);
  String? get phoneNumber => _phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = _phoneNumber;
    return map;
  }

}