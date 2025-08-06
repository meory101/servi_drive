import 'package:dartz/dartz.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/response/login_response_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../../../../core/api/connector.dart';
import '../../domain/entity/request/login_request_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/entity/request/register_request_entity.dart';
import '../../domain/entity/request/verify_otp_request_entity.dart';
import '../../domain/entity/request/resend_otp_request_entity.dart';
import '../../domain/entity/request/forgot_password_request_entity.dart';
import '../../domain/entity/request/reset_password_request_entity.dart';
import '../../domain/entity/response/register_response_entity.dart';
import '../datasource/remote/auth_remote.dart';

class AuthRepositoryImplements implements AuthRepository {
  final AuthRemote remote;

  AuthRepositoryImplements({
    required this.remote,
  });

  @override
  Future<Either<ApiFailure, RegisterResponseEntity>> register({
    required RegisterRequestEntity entity,
  }) async {
    return Connector<RegisterResponseEntity>().connect(
      remote: () async {
        final result = await remote.register(entity: entity);
        
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, LoginResponseEntity>> login({required LoginRequestEntity entity})async {
    return Connector<LoginResponseEntity>().connect(
      remote: () async {
        final result = await remote.login(entity: entity);

        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> verifyOtp({
    required VerifyOtpRequestEntity entity,
  }) async {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.verifyOtp(entity: entity);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> resendOtp({
    required ResendOtpRequestEntity entity,
  }) async {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.resendOtp(entity: entity);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> forgotPassword({
    required ForgotPasswordRequestEntity entity,
  }) async {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.forgotPassword(entity: entity);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> resetPassword({
    required ResetPasswordRequestEntity entity,
  }) async {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.resetPassword(entity: entity);
        return Right(result);
      },
    );
  }
}
