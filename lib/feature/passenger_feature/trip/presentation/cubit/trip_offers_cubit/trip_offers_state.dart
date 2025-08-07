import 'package:equatable/equatable.dart';
import 'package:servi_drive/core/model/trip_data.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/trip_offers_response_entity.dart';

import '../../../../../../core/resource/cubit_status_manager.dart';

class TripOffersState extends Equatable {
  final String error;
  final CubitStatus status;
  final TripOffersResponseEntity? entity;
  final int currentPage;
  final bool hasReachedMax;
  final List<TripData> tripOffers;

  const TripOffersState({
    required this.error,
    required this.status,
    this.entity,
    required this.currentPage,
    required this.hasReachedMax,
    required this.tripOffers,
  });

  factory TripOffersState.initial() {
    return const TripOffersState(
      entity: null,
      error: '',
      status: CubitStatus.initial,
      currentPage: 1,
      hasReachedMax: false,
      tripOffers: [],
    );
  }

  TripOffersState copyWith({
    String? error,
    CubitStatus? status,
    TripOffersResponseEntity? entity,
    int? currentPage,
    bool? hasReachedMax,
    List<TripData>? tripOffers,
  }) {
    return TripOffersState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      tripOffers: tripOffers ?? this.tripOffers,
    );
  }

  @override
  List<Object?> get props => [error, status, entity, currentPage, hasReachedMax, tripOffers];
} 