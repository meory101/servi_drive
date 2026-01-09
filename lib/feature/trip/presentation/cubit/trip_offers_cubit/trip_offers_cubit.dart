import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/usecase/get_trip_offers_usecase.dart';
import 'trip_offers_state.dart';

class TripOffersCubit extends Cubit<TripOffersState> {
  final GetTripOffersUseCase usecase;

  TripOffersCubit({required this.usecase}) : super(TripOffersState.initial());

  void getTripOffers({
    required BuildContext context,
    required String tripId,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      emit(state.copyWith(
        status: CubitStatus.loading,
        currentPage: 1,
        hasReachedMax: false,
        tripOffers: [],
      ));
    } else {
      emit(state.copyWith(status: CubitStatus.loading));
    }

    final result = await usecase(
      page: state.currentPage,
      limit: 10,
      tripId: tripId,
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
        final newOffers = data.data ?? [];
        final updatedOffers = isRefresh ? newOffers : [...state.tripOffers, ...newOffers];
        
        emit(state.copyWith(
          status: CubitStatus.success,
          entity: data,
          tripOffers: updatedOffers,
          hasReachedMax: newOffers.isEmpty,
          currentPage: state.currentPage + 1,
        ));
      },
    );
  }

  void loadMoreOffers({required BuildContext context, required String tripId}) {
    if (!state.hasReachedMax && state.status != CubitStatus.loading) {
      getTripOffers(context: context, tripId: tripId);
    }
  }
} 