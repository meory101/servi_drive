import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/usecase/get_my_trips_usecase.dart';
import 'my_trips_state.dart';

class MyTripsCubit extends Cubit<MyTripsState> {
  final GetMyTripsUseCase usecase;

  MyTripsCubit({
    required this.usecase,
  }) : super(MyTripsState.initial());

  void getMyTrips({
    required BuildContext context,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      emit(state.copyWith(
        status: CubitStatus.loading,
        currentPage: 1,
        trips: [],
        hasReachedMax: false,
      ));
    } else {
      emit(state.copyWith(status: CubitStatus.loading));
    }

    final result = await usecase(
      page: state.currentPage,
      limit: 10,
    );

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
        final newTrips = data.data ?? [];
        final updatedTrips = isRefresh ? newTrips : [...state.trips, ...newTrips];
        
        emit(state.copyWith(
          status: CubitStatus.success,
          entity: data,
          trips: updatedTrips,
          hasReachedMax: newTrips.isEmpty,
          currentPage: state.currentPage + 1,
        ));
      },
    );
  }

  void loadMoreTrips({required BuildContext context}) {
    if (!state.hasReachedMax && state.status != CubitStatus.loading) {
      getMyTrips(context: context);
    }
  }

  void refreshTrips({required BuildContext context}) {
    getMyTrips(context: context, isRefresh: true);
  }
} 