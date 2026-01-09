import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/core/model/trip_data.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/usecase/edit_trip_usecase.dart';
import 'edit_trip_state.dart';

class EditTripCubit extends Cubit<EditTripState> {
  final EditTripUseCase usecase;

  EditTripCubit({
    required this.usecase,
  }) : super(EditTripState.initial());

  void editTrip({
    required BuildContext context,
    required String tripId,
    required TripData tripData,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await usecase(tripId: tripId, tripData: tripData);

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