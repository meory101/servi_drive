import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/api_error/api_error.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../domain/usecase/conditions_usecase.dart';
import 'conditions_state.dart';

/// Eng.Nour Othman ***

class ConditionsCubit extends Cubit<ConditionsState> {
  final ConditionsUsecase usecase;

  ConditionsCubit({
    required this.usecase,
  }) : super(ConditionsState.initial());

  void getConditions({
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
