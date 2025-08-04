import 'package:equatable/equatable.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/response/register_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/trip_routes_response_entity.dart';

import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/entity/response/conditions_response_entity.dart';

/// Eng.nour othman*
class ConditionsState extends Equatable {
  final String error;
  final CubitStatus status;
  final PreferredConditionsResponseEntity entity;

  const ConditionsState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory ConditionsState.initial() {
    return ConditionsState(
      entity: PreferredConditionsResponseEntity(),
      error: '',
      status: CubitStatus.initial,
    );
  }

  ConditionsState copyWith({
    String? error,
    CubitStatus? status,
    PreferredConditionsResponseEntity? entity,
  }) {
    return ConditionsState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  @override
  List<Object> get props => [error, status, entity];
}
