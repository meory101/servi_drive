// import 'package:equatable/equatable.dart';
// import 'package:nilez/core/resource/cubit_status_manager.dart';
// import 'package:nilez/feature/auth/domain/entity/response/verify_otp_response_entity.dart';
//
// /// Eng.nour othman*
// class VerfiyOtpState extends Equatable {
//   final String error;
//   final CubitStatus status;
//   final VerifyOtpResponseEntity entity;
//
//   const VerfiyOtpState({
//     required this.error,
//     required this.status,
//     required this.entity,
//   });
//
//   factory VerfiyOtpState.initial() {
//     return VerfiyOtpState(
//       entity: VerifyOtpResponseEntity(),
//       error: '',
//       status: CubitStatus.initial,
//     );
//   }
//
//   VerfiyOtpState copyWith({
//     String? error,
//     CubitStatus? status,
//     VerifyOtpResponseEntity? entity,
//   }) {
//     return VerfiyOtpState(
//       error: error ?? this.error,
//       status: status ?? this.status,
//       entity: entity ?? this.entity,
//     );
//   }
//
//   @override
//   List<Object> get props => [error, status, entity];
// }
