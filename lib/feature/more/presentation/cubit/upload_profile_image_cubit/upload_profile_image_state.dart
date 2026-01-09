import 'package:equatable/equatable.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';

class UploadProfileImageState extends Equatable {
  final String error;
  final CubitStatus status;

  const UploadProfileImageState({
    required this.error,
    required this.status,
  });

  factory UploadProfileImageState.initial() {
    return const UploadProfileImageState(
      error: '',
      status: CubitStatus.initial,
    );
  }

  UploadProfileImageState copyWith({
    String? error,
    CubitStatus? status,
  }) {
    return UploadProfileImageState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [error, status];
} 