import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/api/api_error/api_failures.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/entity/request/resend_otp_request_entity.dart';
import '../../../domain/usecase/resend_otp_usecase.dart';
import 'resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  final ResendOtpUsecase usecase;

  ResendOtpCubit({
    required this.usecase,
  }) : super(ResendOtpState.initial());

  void resendOtp({
    required BuildContext context,
    required ResendOtpRequestEntity entity,
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