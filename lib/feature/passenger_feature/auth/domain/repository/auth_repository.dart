import 'package:dartz/dartz.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/request/login_request_entity.dart';

import '../../../../../core/api/api_error/api_failures.dart';
import '../entity/request/register_request_entity.dart';
import '../entity/response/login_response_entity.dart';
import '../entity/response/register_response_entity.dart';

///
/// created by eng nour othman ***
/// at 23/2/2025
///
abstract class AuthRepository {
  Future<Either<ApiFailure, RegisterResponseEntity>> register({
    required RegisterRequestEntity entity,
  });

  Future<Either<ApiFailure,LoginResponseEntity>> login({required LoginRequestEntity entity});

}
