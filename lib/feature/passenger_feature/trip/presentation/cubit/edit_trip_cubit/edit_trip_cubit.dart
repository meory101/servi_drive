import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/usecase/get_trip_details_usecase.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import 'edit_trip_state.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  final GetTripDetailsUseCase usecase;

  TripDetailsCubit({
    required this.usecase,
  }) : super(TripDetailsState.initial());

  void getTripDetails({
    required BuildContext context,
    required String tripId,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await usecase(tripId: tripId);

    if (isClosed) return;

    result.fold(
      (failure) async {
        final ErrorEntity errorEntity = await ApiErrorHandler.mapFailure(
            failure: failure, buildContext: context);
        emit(state.copyWith(
          error: errorEntity.errorMessage,
          status: CubitStatus.error,
        ));
      },
      (trip) {
        emit(state.copyWith(
          status: CubitStatus.success,
          trip: trip,
        ));
      },
    );
  }
} 