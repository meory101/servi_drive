import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../../../../core/api/connector.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/entity/request/register_request_entity.dart';
import '../../domain/entity/response/register_response_entity.dart';
import '../datasource/remote/auth_remote.dart';
import '../datasource/local/auth_local.dart';

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
}
