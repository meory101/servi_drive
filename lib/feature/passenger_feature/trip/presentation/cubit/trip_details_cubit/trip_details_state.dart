import 'package:equatable/equatable.dart';
import 'package:servi_drive/core/model/trip_data.dart';

import '../../../../../../core/resource/cubit_status_manager.dart';

class TripDetailsState extends Equatable {
  final String error;
  final CubitStatus status;
  final TripData? trip;

  const TripDetailsState({
    required this.error,
    required this.status,
    this.trip,
  });

  factory TripDetailsState.initial() {
    return const TripDetailsState(
      error: '',
      status: CubitStatus.initial,
      trip: null,
    );
  }

  TripDetailsState copyWith({
    String? error,
    CubitStatus? status,
    TripData? trip,
  }) {
    return TripDetailsState(
      error: error ?? this.error,
      status: status ?? this.status,
      trip: trip ?? this.trip,
    );
  }

  @override
  List<Object?> get props => [error, status, trip];
} 