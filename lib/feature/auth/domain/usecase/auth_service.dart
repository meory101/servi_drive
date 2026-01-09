import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../entity/request/register_request_entity.dart';
import '../entity/request/resend_otp_request_entity.dart';
import '../entity/request/verify_otp_request_entity.dart';
import '../entity/response/register_response_entity.dart';
import 'register_usecase.dart';
import 'verify_otp_usecase.dart';
import 'resend_otp_usecase.dart';
import '../../presentation/cubit/register_cubit/register_cubit.dart';
import '../../presentation/cubit/verfiy_otp_cubit/verfiy_otp_cubit.dart';
import '../../presentation/cubit/resend_otp_cubit/resend_otp_cubit.dart';

class AuthService {
  final RegisterUsecase registerUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final ResendOtpUsecase resendOtpUsecase;

  AuthService({
    required this.registerUsecase,
    required this.verifyOtpUsecase,
    required this.resendOtpUsecase,
  });

  // Direct use case calls
  Future<RegisterResponseEntity?> registerUser(RegisterRequestEntity entity) async {
    final result = await registerUsecase(entity: entity);
    return result.fold(
      (failure) => null,
      (response) => response,
    );
  }

  Future<bool?> verifyOtp(VerifyOtpRequestEntity entity) async {
    final result = await verifyOtpUsecase(entity: entity);
    return result.fold(
      (failure) => null,
      (response) => response,
    );
  }

  Future<bool?> resendOtp(ResendOtpRequestEntity entity) async {
    final result = await resendOtpUsecase(entity: entity);
    return result.fold(
      (failure) => null,
      (response) => response,
    );
  }

  // BLoC usage examples
  void registerWithBloc(BuildContext context, RegisterRequestEntity entity) {
    context.read<RegisterCubit>().register(context: context, entity: entity);
  }

  void verifyOtpWithBloc(BuildContext context, VerifyOtpRequestEntity entity) {
    context.read<VerifyOtpCubit>().verifyOtp(context: context, entity: entity);
  }

  void resendOtpWithBloc(BuildContext context, ResendOtpRequestEntity entity) {
    context.read<ResendOtpCubit>().resendOtp(context: context, entity: entity);
  }

  // Check auth states
  bool isRegisterSuccess(BuildContext context) {
    final state = context.read<RegisterCubit>().state;
    return state.status == CubitStatus.success;
  }

  bool isVerifyOtpSuccess(BuildContext context) {
    final state = context.read<VerifyOtpCubit>().state;
    return state.status == CubitStatus.success;
  }

  bool isResendOtpSuccess(BuildContext context) {
    final state = context.read<ResendOtpCubit>().state;
    return state.status == CubitStatus.success;
  }
} 