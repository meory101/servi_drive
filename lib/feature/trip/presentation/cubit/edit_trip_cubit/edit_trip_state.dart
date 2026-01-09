import 'package:equatable/equatable.dart';
import 'package:servi_drive/core/model/trip_data.dart';

import '../../../../../../core/resource/cubit_status_manager.dart';

class EditTripState extends Equatable {
  final String error;
  final CubitStatus status;
  final TripData? trip;

  const EditTripState({
    required this.error,
    required this.status,
    this.trip,
  });

  factory EditTripState.initial() {
    return const EditTripState(
      error: '',
      status: CubitStatus.initial,
      trip: null,
    );
  }

  EditTripState copyWith({
    String? error,
    CubitStatus? status,
    TripData? trip,
  }) {
    return EditTripState(
      error: error ?? this.error,
      status: status ?? this.status,
      trip: trip ?? this.trip,
    );
  }

  @override
  List<Object?> get props => [error, status, trip];
} 