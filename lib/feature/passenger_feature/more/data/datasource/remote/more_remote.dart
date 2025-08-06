
import 'package:servi_drive/feature/passenger_feature/more/domain/entity/response/profile_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/more/domain/entity/request/upload_profile_image_request_entity.dart';
import '../../../../../../core/api/api_error/api_exception.dart';
import '../../../../../../core/api/api_error/api_status_code.dart';
import '../../../../../../core/api/api_links.dart';
import '../../../../../../core/api/api_methods.dart';


///
/// created by eng nour othman ***
/// at 23/2/2025
///

abstract class MoreRemote {
  Future<ProfileResponseEntity> getProfile();
  Future<bool> uploadProfileImage({required UploadProfileImageRequestEntity entity});
}

class MoreRemoteImplement extends MoreRemote {

  @override
  Future<ProfileResponseEntity> getProfile() async {
    final response =
        await ApiMethods().get(url: ApiGetUrl.profile);

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return profileResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> uploadProfileImage({required UploadProfileImageRequestEntity entity}) async {
    final response =
        await ApiMethods().patch(url: ApiPutUrl.uploadProfileImage, body: entity.toJson());

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }
}
