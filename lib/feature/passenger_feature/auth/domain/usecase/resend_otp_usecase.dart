import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../repository/auth_repository.dart';
import '../entity/request/resend_otp_request_entity.dart';

class ResendOtpUsecase {
  final AuthRepository repository;

  ResendOtpUsecase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required ResendOtpRequestEntity entity,
  }) async {
    return await repository.resendOtp(entity: entity);
  }
} 