import 'dart:convert';

import '../../../../../../core/model/trip_route.dart';

TripRoutesResponseEntity tripRoutesResponseEntityFromJson(String str) =>
    TripRoutesResponseEntity.fromJson(json.decode(str));

String tripRoutesResponseEntityToJson(TripRoutesResponseEntity data) =>
    json.encode(data.toJson());

class TripRoutesResponseEntity {
  TripRoutesResponseEntity({
    List<TripRoute>? routes,
  }) {
    _routes = routes;
  }

  TripRoutesResponseEntity.fromJson(dynamic json) {
    if (json is List) {
      _routes = json.map((e) => TripRoute.fromJson(e)).toList();
    }
  }

  List<TripRoute>? _routes;

  List<TripRoute>? get routes => _routes;

  Map<String, dynamic> toJson() {
    return {
      'routes': _routes?.map((e) => e.toJson()).toList(),
    };
  }
}

