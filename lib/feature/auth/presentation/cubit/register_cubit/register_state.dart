import 'package:equatable/equatable.dart';

import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/entity/response/register_response_entity.dart';

/// Eng.nour othman*
class RegisterState extends Equatable {
  final String error;
  final CubitStatus status;
  final RegisterResponseEntity entity;

  const RegisterState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory RegisterState.initial() {
    return RegisterState(
      entity: RegisterResponseEntity(),
      error: '',
      status: CubitStatus.initial,
    );
  }

  RegisterState copyWith({
    String? error,
    CubitStatus? status,
    RegisterResponseEntity? entity,
  }) {
    return RegisterState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  @override
  List<Object> get props => [error, status, entity];
}
