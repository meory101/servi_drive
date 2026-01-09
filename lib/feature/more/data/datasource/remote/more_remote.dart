
import '../../../../../../core/api/api_error/api_exception.dart';
import '../../../../../../core/api/api_error/api_status_code.dart';
import '../../../../../../core/api/api_links.dart';
import '../../../../../../core/api/api_methods.dart';
import '../../../domain/entity/request/edit_profile_request_entity.dart';
import '../../../domain/entity/request/upload_profile_image_request_entity.dart';
import '../../../domain/entity/response/profile_response_entity.dart';


///
/// created by eng nour othman ***
/// at 23/2/2025
///

abstract class MoreRemote {
  Future<ProfileResponseEntity> getProfile();
  Future<bool> uploadProfileImage({required UploadProfileImageRequestEntity entity});
  Future<bool> editProfile({required EditProfileRequestEntity entity});
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
        await ApiMethods().put(url: ApiPutUrl.uploadProfileImage, body: entity.toJson(), query: {});

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> editProfile({required EditProfileRequestEntity entity}) async {
    final response =
        await ApiMethods().put(url: ApiPutUrl.editProfile, body: entity.toJson(), query: {});

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }
}
