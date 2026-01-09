import 'package:equatable/equatable.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';

class VerifyOtpState extends Equatable {
  final String error;
  final CubitStatus status;

  const VerifyOtpState({
    required this.error,
    required this.status,
  });

  factory VerifyOtpState.initial() {
    return const VerifyOtpState(
      error: '',
      status: CubitStatus.initial,
    );
  }

  VerifyOtpState copyWith({
    String? error,
    CubitStatus? status,
  }) {
    return VerifyOtpState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [error, status];
}
