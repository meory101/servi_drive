import 'package:equatable/equatable.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';

class ForgotPasswordState extends Equatable {
  final String error;
  final CubitStatus status;

  const ForgotPasswordState({
    required this.error,
    required this.status,
  });

  factory ForgotPasswordState.initial() {
    return const ForgotPasswordState(
      error: '',
      status: CubitStatus.initial,
    );
  }

  ForgotPasswordState copyWith({
    String? error,
    CubitStatus? status,
  }) {
    return ForgotPasswordState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [error, status];
} 