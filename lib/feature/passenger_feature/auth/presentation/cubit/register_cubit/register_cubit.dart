import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/request/register_request_entity.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/response/register_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/register_cubit/register_state.dart';

import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../../../../core/storage/shared/shared_pref.dart';
import '../../../domain/usecase/register_usecase.dart';

/// Eng.Nour Othman ***

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase usecase;

  RegisterCubit({
    required this.usecase,
  }) : super(RegisterState.initial());

  void register({
    required BuildContext context,
    required RegisterRequestEntity entity,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await usecase(entity: entity);

    if (isClosed) return;

    result.fold(
      (failure) async {
        final ErrorEntity errorEntity = await ApiErrorHandler.mapFailure(
            failure: failure, buildContext: context);
        ;
        emit(state.copyWith(
          error: errorEntity.errorMessage,
          status: CubitStatus.error,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: CubitStatus.success,
        ));
        AppSharedPreferences.cashToken(token: data.accessToken ??"");
      },
    );
  }
}
