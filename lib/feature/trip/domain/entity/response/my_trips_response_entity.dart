import 'dart:convert';

import '../../../../../../core/model/trip_data.dart';

MyTripsResponseEntity myTripsResponseEntityFromJson(String str) => MyTripsResponseEntity.fromJson(json.decode(str));
String myTripsResponseEntityToJson(MyTripsResponseEntity data) => json.encode(data.toJson());
class MyTripsResponseEntity {
  MyTripsResponseEntity({
      List<TripData>? data,}){
    _data = data;
}

  MyTripsResponseEntity.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TripData.fromJson(v));
      });
    }
  }
  List<TripData>? _data;
MyTripsResponseEntity copyWith({  List<TripData>? data,
}) => MyTripsResponseEntity(  data: data ?? _data,
);
  List<TripData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

