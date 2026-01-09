import 'dart:convert';
/// image : "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD..."

UploadProfileImageRequestEntity uploadProfileImageRequestEntityFromJson(String str) => UploadProfileImageRequestEntity.fromJson(json.decode(str));
String uploadProfileImageRequestEntityToJson(UploadProfileImageRequestEntity data) => json.encode(data.toJson());
class UploadProfileImageRequestEntity {
  UploadProfileImageRequestEntity({
      String? image,}){
    _image = image;
}

  UploadProfileImageRequestEntity.fromJson(dynamic json) {
    _image = json['image'];
  }
  String? _image;
UploadProfileImageRequestEntity copyWith({  String? image,
}) => UploadProfileImageRequestEntity(  image: image ?? _image,
);
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    return map;
  }

}