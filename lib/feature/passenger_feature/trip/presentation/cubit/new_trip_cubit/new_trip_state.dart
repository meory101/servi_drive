import 'package:equatable/equatable.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/response/register_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/trip_routes_response_entity.dart';

import '../../../../../../core/resource/cubit_status_manager.dart';

/// Eng.nour othman*
class NewTripState extends Equatable {
  final String error;
  final CubitStatus status;
  final bool entity;

  const NewTripState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory NewTripState.initial() {
    return NewTripState(
      entity: false,
      error: '',
      status: CubitStatus.initial,
    );
  }

  NewTripState copyWith({
    String? error,
    CubitStatus? status,
    bool? entity,
  }) {
    return NewTripState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  @override
  List<Object> get props => [error, status, entity];
}
