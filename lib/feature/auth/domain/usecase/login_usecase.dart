import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../entity/request/login_request_entity.dart';
import '../entity/response/login_response_entity.dart';
import '../repository/auth_repository.dart';
import '../entity/request/register_request_entity.dart';
import '../entity/response/register_response_entity.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase({required this.repository});

  Future<Either<ApiFailure, LoginResponseEntity>> call({
    required LoginRequestEntity entity,
  }) async {
    return await repository.login(entity: entity);
  }
}
