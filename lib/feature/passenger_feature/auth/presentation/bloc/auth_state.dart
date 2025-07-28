import 'package:equatable/equatable.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../domain/entity/response/register_response_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final RegisterResponseEntity response;

  const AuthSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class AuthFailure extends AuthState {
  final ApiFailure failure;

  const AuthFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
} 