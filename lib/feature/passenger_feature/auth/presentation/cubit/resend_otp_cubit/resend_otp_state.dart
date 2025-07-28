import 'package:equatable/equatable.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';

class ResendOtpState extends Equatable {
  final String error;
  final CubitStatus status;

  const ResendOtpState({
    required this.error,
    required this.status,
  });

  factory ResendOtpState.initial() {
    return const ResendOtpState(
      error: '',
      status: CubitStatus.initial,
    );
  }

  ResendOtpState copyWith({
    String? error,
    CubitStatus? status,
  }) {
    return ResendOtpState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [error, status];
} 