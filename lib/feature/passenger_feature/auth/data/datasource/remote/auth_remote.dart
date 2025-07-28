

import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/request/resend_otp_request_entity.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/request/verify_otp_request_entity.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/response/login_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/response/register_response_entity.dart';
import '../../../../../../core/api/api_error/api_exception.dart';
import '../../../../../../core/api/api_error/api_status_code.dart';
import '../../../../../../core/api/api_links.dart';
import '../../../../../../core/api/api_methods.dart';
import '../../../domain/entity/request/login_request_entity.dart';
import '../../../domain/entity/request/register_request_entity.dart';

///
/// created by eng nour othman ***
/// at 23/2/2025
///

abstract class AuthRemote {
  Future<RegisterResponseEntity> register({required RegisterRequestEntity entity});
  Future<LoginResponseEntity> login({required LoginRequestEntity entity});
  Future<bool> verifyOtp({required VerifyOtpRequestEntity entity});
  Future<bool> resendOtp({required ResendOtpRequestEntity entity});

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

  @override
  Future<LoginResponseEntity> login({required LoginRequestEntity entity}) async{
    final response =
    await ApiMethods().post(url: ApiPostUrl.login,body: entity.toJson());

    if (ApiStatusCode.success().contains(response.statusCode) || response.statusCode == 401) {
      return loginResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> verifyOtp({required VerifyOtpRequestEntity entity})async {
    final response =
        await ApiMethods().post(url: ApiPostUrl.verifyOtp,body: entity.toJson());

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> resendOtp({required ResendOtpRequestEntity entity}) async{
    final response =
    await ApiMethods().post(url: ApiPostUrl.resendOtp,body: entity.toJson());

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }
}
