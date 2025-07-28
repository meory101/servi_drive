import 'package:equatable/equatable.dart';
import '../../domain/entity/request/register_request_entity.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final RegisterRequestEntity entity;

  const RegisterEvent({required this.entity});

  @override
  List<Object?> get props => [entity];
} 