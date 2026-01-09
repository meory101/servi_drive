import 'package:equatable/equatable.dart';

import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/entity/response/login_response_entity.dart';

/// Eng.nour othman*
///
class LoginState extends Equatable {
  final String error;
  final CubitStatus status;
  final LoginResponseEntity entity;

  const LoginState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory LoginState.initial() {
    return LoginState(
      entity: LoginResponseEntity(),
      error: '',
      status: CubitStatus.initial,
    );
  }

  LoginState copyWith({
    String? error,
    CubitStatus? status,
    LoginResponseEntity? entity,
  }) {
    return LoginState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  @override
  List<Object> get props => [error, status, entity];
}
