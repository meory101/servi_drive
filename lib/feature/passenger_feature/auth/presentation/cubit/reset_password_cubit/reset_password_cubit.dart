import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/api/api_error/api_failures.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/entity/request/reset_password_request_entity.dart';
import '../../../domain/usecase/reset_password_usecase.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUsecase usecase;

  ResetPasswordCubit({
    required this.usecase,
  }) : super(ResetPasswordState.initial());

  void resetPassword({
    required BuildContext context,
    required ResetPasswordRequestEntity entity,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));
    
    final result = await usecase(entity: entity);

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
      (success) {
        emit(state.copyWith(
          status: CubitStatus.success,
        ));
      },
    );
  }
} 