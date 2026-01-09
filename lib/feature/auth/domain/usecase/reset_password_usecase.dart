import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../repository/auth_repository.dart';
import '../entity/request/reset_password_request_entity.dart';

class ResetPasswordUsecase {
  final AuthRepository repository;

  ResetPasswordUsecase({required this.repository});

  Future<Either<ApiFailure, bool>> call({
    required ResetPasswordRequestEntity entity,
  }) async {
    return await repository.resetPassword(entity: entity);
  }
} 