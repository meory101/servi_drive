import 'dart:convert';


NewTripRequestEntity newTripRequestEntityFromJson(String str) => NewTripRequestEntity.fromJson(json.decode(str));
String newTripRequestEntityToJson(NewTripRequestEntity data) => json.encode(data.toJson());
class NewTripRequestEntity {
  NewTripRequestEntity({
      String? routeId, 
      num? fromLat, 
      num? fromLng, 
      num? toLat, 
      num? toLng, 
      num? numberOfTravelers, 
      String? tripDate, 
      String? tripTime, 
      num? budget, 
      num? luggageCount, 
      String? description, 
      bool? isUrgent, 
      List<String>? conditions,}){
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
    _description = description;
    _isUrgent = isUrgent;
    _conditions = conditions;
}

  NewTripRequestEntity.fromJson(dynamic json) {
    _routeId = json['routeId'];
    _fromLat = json['fromLat'];
    _fromLng = json['fromLng'];
    _toLat = json['toLat'];
    _toLng = json['toLng'];
    _numberOfTravelers = json['numberOfTravelers'];
    _tripDate = json['tripDate'];
    _tripTime = json['tripTime'];
    _budget = json['budget'];
    _luggageCount = json['luggageCount'];
    _description = json['description'];
    _isUrgent = json['isUrgent'];
    _conditions = json['conditions'] != null ? json['conditions'].cast<String>() : [];
  }
  String? _routeId;
  num? _fromLat;
  num? _fromLng;
  num? _toLat;
  num? _toLng;
  num? _numberOfTravelers;
  String? _tripDate;
  String? _tripTime;
  num? _budget;
  num? _luggageCount;
  String? _description;
  bool? _isUrgent;
  List<String>? _conditions;
NewTripRequestEntity copyWith({  String? routeId,
  num? fromLat,
  num? fromLng,
  num? toLat,
  num? toLng,
  num? numberOfTravelers,
  String? tripDate,
  String? tripTime,
  num? budget,
  num? luggageCount,
  String? description,
  bool? isUrgent,
  List<String>? conditions,
}) => NewTripRequestEntity(  routeId: routeId ?? _routeId,
  fromLat: fromLat ?? _fromLat,
  fromLng: fromLng ?? _fromLng,
  toLat: toLat ?? _toLat,
  toLng: toLng ?? _toLng,
  numberOfTravelers: numberOfTravelers ?? _numberOfTravelers,
  tripDate: tripDate ?? _tripDate,
  tripTime: tripTime ?? _tripTime,
  budget: budget ?? _budget,
  luggageCount: luggageCount ?? _luggageCount,
  description: description ?? _description,
  isUrgent: isUrgent ?? _isUrgent,
  conditions: conditions ?? _conditions,
);
  String? get routeId => _routeId;
  num? get fromLat => _fromLat;
  num? get fromLng => _fromLng;
  num? get toLat => _toLat;
  num? get toLng => _toLng;
  num? get numberOfTravelers => _numberOfTravelers;
  String? get tripDate => _tripDate;

  set routeId(String? value) {
    _routeId = value;
  }

  String? get tripTime => _tripTime;
  num? get budget => _budget;
  num? get luggageCount => _luggageCount;
  String? get description => _description;
  bool? get isUrgent => _isUrgent;
  List<String>? get conditions => _conditions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['routeId'] = _routeId;
    map['fromLat'] = _fromLat;
    map['fromLng'] = _fromLng;
    map['toLat'] = _toLat;
    map['toLng'] = _toLng;
    map['numberOfTravelers'] = _numberOfTravelers;
    map['tripDate'] = _tripDate;
    map['tripTime'] = _tripTime;
    map['budget'] = _budget;
    map['luggageCount'] = _luggageCount;
    map['description'] = _description;
    map['isUrgent'] = _isUrgent;
    map['conditions'] = _conditions;
    return map;
  }

  set fromLat(num? value) {
    _fromLat = value;
  }

  set fromLng(num? value) {
    _fromLng = value;
  }

  set toLat(num? value) {
    _toLat = value;
  }

  set toLng(num? value) {
    _toLng = value;
  }

  set numberOfTravelers(num? value) {
    _numberOfTravelers = value;
  }

  set tripDate(String? value) {
    _tripDate = value;
  }

  set tripTime(String? value) {
    _tripTime = value;
  }

  set budget(num? value) {
    _budget = value;
  }

  set luggageCount(num? value) {
    _luggageCount = value;
  }

  set description(String? value) {
    _description = value;
  }

  set isUrgent(bool? value) {
    _isUrgent = value;
  }

  set conditions(List<String>? value) {
    _conditions = value;
  }
}