import 'dart:convert';

import '../../../../../../core/model/trip_data.dart';

TripOffersResponseEntity tripOffersResponseEntityFromJson(String str) => TripOffersResponseEntity.fromJson(json.decode(str));
String tripOffersResponseEntityToJson(TripOffersResponseEntity data) => json.encode(data.toJson());

class TripOffersResponseEntity {
  TripOffersResponseEntity({
    List<TripData>? data,
    int? totalPages,
    int? currentPage,
    int? totalItems,
    int? itemsPerPage,
  }) {
    _data = data;
    _totalPages = totalPages;
    _currentPage = currentPage;
    _totalItems = totalItems;
    _itemsPerPage = itemsPerPage;
  }

  TripOffersResponseEntity.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TripData.fromJson(v));
      });
    }
    _totalPages = json['totalPages'];
    _currentPage = json['currentPage'];
    _totalItems = json['totalItems'];
    _itemsPerPage = json['itemsPerPage'];
  }

  List<TripData>? _data;
  int? _totalPages;
  int? _currentPage;
  int? _totalItems;
  int? _itemsPerPage;

  TripOffersResponseEntity copyWith({
    List<TripData>? data,
    int? totalPages,
    int? currentPage,
    int? totalItems,
    int? itemsPerPage,
  }) => TripOffersResponseEntity(
    data: data ?? _data,
    totalPages: totalPages ?? _totalPages,
    currentPage: currentPage ?? _currentPage,
    totalItems: totalItems ?? _totalItems,
    itemsPerPage: itemsPerPage ?? _itemsPerPage,
  );

  List<TripData>? get data => _data;
  int? get totalPages => _totalPages;
  int? get currentPage => _currentPage;
  int? get totalItems => _totalItems;
  int? get itemsPerPage => _itemsPerPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['totalPages'] = _totalPages;
    map['currentPage'] = _currentPage;
    map['totalItems'] = _totalItems;
    map['itemsPerPage'] = _itemsPerPage;
    return map;
  }
} 