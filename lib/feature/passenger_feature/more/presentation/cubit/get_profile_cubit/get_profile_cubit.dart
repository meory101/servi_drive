import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/api/api_error/api_failures.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/usecase/get_profile_usecase.dart';
import 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  final GetProfileUsecase usecase;

  GetProfileCubit({
    required this.usecase,
  }) : super(GetProfileState.initial());

  void getProfile({
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
      (profile) {
        emit(state.copyWith(
          status: CubitStatus.success,
          profile: profile,
        ));
      },
    );
  }
} 