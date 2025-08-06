import 'package:equatable/equatable.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/entity/response/profile_response_entity.dart';

class GetProfileState extends Equatable {
  final String error;
  final CubitStatus status;
  final ProfileResponseEntity? profile;

  const GetProfileState({
    required this.error,
    required this.status,
    this.profile,
  });

  factory GetProfileState.initial() {
    return const GetProfileState(
      error: '',
      status: CubitStatus.initial,
      profile: null,
    );
  }

  GetProfileState copyWith({
    String? error,
    CubitStatus? status,
    ProfileResponseEntity? profile,
  }) {
    return GetProfileState(
      error: error ?? this.error,
      status: status ?? this.status,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [error, status, profile];
} 