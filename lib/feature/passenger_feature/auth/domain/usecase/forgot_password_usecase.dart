import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../repository/auth_repository.dart';
import '../entity/request/forgot_password_request_entity.dart';

class ForgotPasswordUsecase {
  final AuthRepository repository;

  ForgotPasswordUsecase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required ForgotPasswordRequestEntity entity,
  }) async {
    return await repository.forgotPassword(entity: entity);
  }
} 