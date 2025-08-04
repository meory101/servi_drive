import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/request/register_request_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/usecase/trip_routes_usecase.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/trip_routes_cubit/trip_routes_state.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';

/// Eng.Nour Othman ***

class TripRoutesCubit extends Cubit<TripRoutesState> {
  final TripRoutesUsecase usecase;

  TripRoutesCubit({
    required this.usecase,
  }) : super(TripRoutesState.initial());

  void getTripRoutes({
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await usecase();

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
      (data) {
        emit(state.copyWith(
          status: CubitStatus.success,
          entity: data
        ));
      },
    );
  }
}
