import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../repository/auth_repository.dart';
import '../entity/request/register_request_entity.dart';
import '../entity/response/register_response_entity.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase({required this.repository});

  Future<Either<ApiFailure, RegisterResponseEntity>> call({
    required RegisterRequestEntity entity,
  }) async {
    return await repository.register(entity: entity);
  }
}
