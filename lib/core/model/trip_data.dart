
import 'dart:convert';

import 'package:servi_drive/core/model/trip_route.dart';
import 'package:servi_drive/core/model/user.dart';

import 'condition.dart';

TripData tripDataFromJson(String str) => TripData.fromJson(json.decode(str));
String dataToJson(TripData data) => json.encode(data.toJson());
class TripData {
  TripData({
    String? id,
    User? passengerId,
    TripRoute? routeId,
    num? fromLat,
    num? fromLng,
    num? toLat,
    num? toLng,
    num? numberOfTravelers,
    String? tripDate,
    String? tripTime,
    num? budget,
    num? luggageCount,
    String? status,
    bool? isUrgent,
    List<PreferredCondition>? conditions,
    String? createdAt,
    String? updatedAt,
    num? v,}){
    _id = id;
    _passengerId = passengerId;
    _routeId = routeId;
    _fromLat = fromLat;
    _fromLng = fromLng;
    _toLat = toLat;
    _toLng = toLng;
    _numberOfTravelers = numberOfTravelers;
    _tripDate = tripDate;
    _tripTime = tripTime;
    _budget = budget;
    _luggageCount = luggageCount;
    _status = status;
    _isUrgent = isUrgent;
    _conditions = conditions;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  TripData.fromJson(dynamic json) {
    _id = json['_id'];
    _passengerId = json['passengerId'] != null ? User.fromJson(json['passengerId']) : null;
    _routeId = json['routeId'] != null ? TripRoute.fromJson(json['routeId']) : null;
    _fromLat = json['fromLat'];
    _fromLng = json['fromLng'];
    _toLat = json['toLat'];
    _toLng = json['toLng'];
    _numberOfTravelers = json['numberOfTravelers'];
    _tripDate = json['tripDate'];
    _tripTime = json['tripTime'];
    _budget = json['budget'];
    _luggageCount = json['luggageCount'];
    _status = json['status'];
    _isUrgent = json['isUrgent'];
    // if (json['conditions'] != null) {
    //   _conditions = [];
    //   print( json['conditions']);
    //   print('ffffffffffffffffffffff');
    //   json['conditions'].forEach((v) {
    //     _conditions?.add(PreferredCondition.fromJson(v));
    //   });
    // }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  User? _passengerId;
  TripRoute? _routeId;
  num? _fromLat;
  num? _fromLng;
  num? _toLat;
  num? _toLng;
  num? _numberOfTravelers;
  String? _tripDate;
  String? _tripTime;
  num? _budget;
  num? _luggageCount;
  String? _status;
  bool? _isUrgent;
  List<PreferredCondition>? _conditions;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  TripData copyWith({  String? id,
    User? passengerId,
    TripRoute? routeId,
    num? fromLat,
    num? fromLng,
    num? toLat,
    num? toLng,
    num? numberOfTravelers,
    String? tripDate,
    String? tripTime,
    num? budget,
    num? luggageCount,
    String? status,
    bool? isUrgent,
    List<PreferredCondition>? conditions,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) => TripData(  id: id ?? _id,
    passengerId: passengerId ?? _passengerId,
    routeId: routeId ?? _routeId,
    fromLat: fromLat ?? _fromLat,
    fromLng: fromLng ?? _fromLng,
    toLat: toLat ?? _toLat,
    toLng: toLng ?? _toLng,
    numberOfTravelers: numberOfTravelers ?? _numberOfTravelers,
    tripDate: tripDate ?? _tripDate,
    tripTime: tripTime ?? _tripTime,
    budget: budget ?? _budget,
    luggageCount: luggageCount ?? _luggageCount,
    status: status ?? _status,
    isUrgent: isUrgent ?? _isUrgent,
    conditions: conditions ?? _conditions,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    v: v ?? _v,
  );
  String? get id => _id;
  User? get passengerId => _passengerId;
  TripRoute? get routeId => _routeId;
  num? get fromLat => _fromLat;
  num? get fromLng => _fromLng;
  num? get toLat => _toLat;
  num? get toLng => _toLng;
  num? get numberOfTravelers => _numberOfTravelers;
  String? get tripDate => _tripDate;
  List<PreferredCondition>? get conditions => _conditions;
  String? get tripTime => _tripTime;
  num? get budget => _budget;
  num? get luggageCount => _luggageCount;
  String? get status => _status;
  bool? get isUrgent => _isUrgent;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_passengerId != null) {
      map['passengerId'] = _passengerId?.toJson();
    }
    if (_routeId != null) {
      map['routeId'] = _routeId?.toJson();
    }
    map['fromLat'] = _fromLat;
    map['fromLng'] = _fromLng;
    map['toLat'] = _toLat;
    map['toLng'] = _toLng;
    map['numberOfTravelers'] = _numberOfTravelers;
    map['tripDate'] = _tripDate;
    map['tripTime'] = _tripTime;
    map['budget'] = _budget;
    map['luggageCount'] = _luggageCount;
    map['status'] = _status;
    map['isUrgent'] = _isUrgent;
    if (_conditions != null) {
      map['conditions'] = _conditions?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

  set status(String? value) {
    _status = value;
  }
}