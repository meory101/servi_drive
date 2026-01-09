import 'package:equatable/equatable.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';

class EditProfileState extends Equatable {
  final String error;
  final CubitStatus status;

  const EditProfileState({
    required this.error,
    required this.status,
  });

  factory EditProfileState.initial() {
    return const EditProfileState(
      error: '',
      status: CubitStatus.initial,
    );
  }

  EditProfileState copyWith({
    String? error,
    CubitStatus? status,
  }) {
    return EditProfileState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [error, status];
} 