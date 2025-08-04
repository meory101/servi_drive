import 'package:equatable/equatable.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/response/register_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/trip_routes_response_entity.dart';

import '../../../../../../core/resource/cubit_status_manager.dart';

/// Eng.nour othman*
class TripRoutesState extends Equatable {
  final String error;
  final CubitStatus status;
  final TripRoutesResponseEntity entity;

  const TripRoutesState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory TripRoutesState.initial() {
    return TripRoutesState(
      entity: TripRoutesResponseEntity(),
      error: '',
      status: CubitStatus.initial,
    );
  }

  TripRoutesState copyWith({
    String? error,
    CubitStatus? status,
    TripRoutesResponseEntity? entity,
  }) {
    return TripRoutesState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  @override
  List<Object> get props => [error, status, entity];
}
