import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../repository/auth_repository.dart';
import '../entity/request/verify_otp_request_entity.dart';

class VerifyOtpUsecase {
  final AuthRepository repository;

  VerifyOtpUsecase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required VerifyOtpRequestEntity entity,
  }) async {
    return await repository.verifyOtp(entity: entity);
  }
} 