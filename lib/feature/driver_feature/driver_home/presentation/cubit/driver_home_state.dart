import 'package:equatable/equatable.dart';
import 'package:servi_drive/core/model/trip_data.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/my_trips_response_entity.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';

class DriverHomeState extends Equatable {
  final String error;
  final CubitStatus status;
  final MyTripsResponseEntity? entity;
  final int currentPage;
  final bool hasReachedMax;
  final List<TripData> trips;

  const DriverHomeState({
    required this.error,
    required this.status,
    this.entity,
    required this.currentPage,
    required this.hasReachedMax,
    required this.trips,
  });

  factory DriverHomeState.initial() {
    return const DriverHomeState(
      entity: null,
      error: '',
      status: CubitStatus.initial,
      currentPage: 1,
      hasReachedMax: false,
      trips: [],
    );
  }

  DriverHomeState copyWith({
    String? error,
    CubitStatus? status,
    MyTripsResponseEntity? entity,
    int? currentPage,
    bool? hasReachedMax,
    List<TripData>? trips,
  }) {
    return DriverHomeState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      trips: trips ?? this.trips,
    );
  }

  @override
  List<Object?> get props => [error, status, entity, currentPage, hasReachedMax, trips];
}


