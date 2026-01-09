import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/api/api_error/api_failures.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/entity/request/forgot_password_request_entity.dart';
import '../../../domain/usecase/forgot_password_usecase.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUsecase usecase;

  ForgotPasswordCubit({
    required this.usecase,
  }) : super(ForgotPasswordState.initial());

  void forgotPassword({
    required BuildContext context,
    required ForgotPasswordRequestEntity entity,
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