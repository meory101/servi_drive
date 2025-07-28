

import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/response/register_response_entity.dart';

import '../../../../../../core/api/api_error/api_exception.dart';
import '../../../../../../core/api/api_error/api_status_code.dart';
import '../../../../../../core/api/api_links.dart';
import '../../../../../../core/api/api_methods.dart';
import '../../../domain/entity/request/register_request_entity.dart';

///
/// created by eng nour othman ***
/// at 23/2/2025
///

abstract class AuthRemote {
  Future<RegisterResponseEntity> register({required RegisterRequestEntity entity});

}

class AuthRemoteImplement extends AuthRemote {


  @override
  Future<RegisterResponseEntity> register({required RegisterRequestEntity entity})async {
    final response =
        await ApiMethods().post(url: ApiPostUrl.register,body: entity.toJson());

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return registerResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }
}
