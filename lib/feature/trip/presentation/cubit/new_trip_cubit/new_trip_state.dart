import 'package:equatable/equatable.dart';

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
