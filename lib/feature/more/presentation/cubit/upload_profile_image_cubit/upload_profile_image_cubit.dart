import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/api/api_error/api_failures.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/entity/request/upload_profile_image_request_entity.dart';
import '../../../domain/usecase/upload_profile_image_usecase.dart';
import 'upload_profile_image_state.dart';

class UploadProfileImageCubit extends Cubit<UploadProfileImageState> {
  final UploadProfileImageUsecase usecase;

  UploadProfileImageCubit({
    required this.usecase,
  }) : super(UploadProfileImageState.initial());

  void uploadProfileImage({
    required BuildContext context,
    required UploadProfileImageRequestEntity entity,
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