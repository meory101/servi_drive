// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nilez/core/storage/shared/shared_pref.dart';
//  import 'package:nilez/feature/auth/domain/entity/request/verify_otp_request_entity.dart';
// import 'package:nilez/feature/auth/domain/usecase/verfiy_otp_usecase.dart';
// import 'package:nilez/feature/auth/presentation/cubit/verfiy_otp_cubit/register_state.dart';
//
// import '../../../../../../core/api/api_error/api_error.dart';
// import '../../../../../../core/resource/cubit_status_manager.dart';
//
// /// Eng.Hussaen Baaghdadi
//
// class VerfiyOtpCubit extends Cubit<VerfiyOtpState> {
//   final VerfiyOtpUsecase usecase;
//
//   VerfiyOtpCubit({
//     required this.usecase,
//   }) : super(VerfiyOtpState.initial());
//
//   void verfiyOtp({
//     required BuildContext context,
//     required VerifyOtpRequestEntity entity,
//   }) async {
//     emit(state.copyWith(status: CubitStatus.loading));
//     final result = await usecase(entity: entity);
//
//     if (isClosed) return;
//
//     result.fold(
//       (failure) async {
//         final ErrorEntity errorEntity = await ApiErrorHandler.mapFailure(
//             failure: failure, buildContext: context);
//         ;
//         emit(state.copyWith(
//           error: errorEntity.errorMessage,
//           status: CubitStatus.error,
//         ));
//       },
//       (data) {
//         AppSharedPreferences.clear();
//         emit(state.copyWith(
//           status: CubitStatus.success,
//         ));
//         AppSharedPreferences.cashToken(token: data.data?.accessToken ?? "");
//       },
//     );
//   }
// }
