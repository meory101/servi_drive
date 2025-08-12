import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/core/api/api_error/api_error.dart';
import 'package:servi_drive/core/api/api_error/api_status_code.dart';
import 'package:servi_drive/core/api/api_error/api_failures.dart';
import 'package:servi_drive/core/api/api_links.dart';
import 'package:servi_drive/core/api/api_methods.dart';
import 'package:servi_drive/core/resource/enum_manager.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/my_trips_response_entity.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  DriverHomeCubit() : super(DriverHomeState.initial());

  void fetchAvailableTrips({
    required BuildContext context,
    bool isRefresh = false,
    bool isUrgent = true,
    List<int>? status,
  }) async {

    status =[int.tryParse(EnumManager.pendingTripCode)??1];
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

    final String base = ApiGetUrl.availableTrips;
    final uri = '$base?isUrgent=$isUrgent&page=${state.currentPage}&limit=10'
        '${status.isNotEmpty ? status.map((s) => '&status=$s').join('') : ''}';

    try {
      final response = await ApiMethods().get(url: uri);
      if (ApiStatusCode.success().contains(response.statusCode)) {
        final data = myTripsResponseEntityFromJson(response.body);
        final newTrips = data.data ?? [];
        final updatedTrips = isRefresh ? newTrips : [...state.trips, ...newTrips];

        emit(state.copyWith(
          status: CubitStatus.success,
          entity: data,
          trips: updatedTrips,
          hasReachedMax: newTrips.isEmpty,
          currentPage: state.currentPage + 1,
        ));
      } else {
        final errorEntity = await ApiErrorHandler.mapFailure(
            failure: ApiServerFailure(response: response),
            buildContext: context);
        emit(state.copyWith(
          error: errorEntity.errorMessage,
          status: CubitStatus.error,
        ));
      }
    } catch (e) {
      final errorEntity = await ApiErrorHandler.mapFailure(
          failure: ApiServerFailure(), buildContext: context);
      emit(state.copyWith(
        error: errorEntity.errorMessage,
        status: CubitStatus.error,
      ));
    }
  }

  void loadMore({required BuildContext context, bool isUrgent = true, List<int>? status}) {
    if (!state.hasReachedMax && state.status != CubitStatus.loading) {
      fetchAvailableTrips(context: context, isUrgent: isUrgent, status: status);
    }
  }

  void refresh({required BuildContext context, bool isUrgent = true, List<int>? status}) {
    fetchAvailableTrips(context: context, isRefresh: true, isUrgent: isUrgent, status: status);
  }
}


