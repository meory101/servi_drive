
import 'package:servi_drive/feature/passenger_feature/more/domain/entity/response/profile_response_entity.dart';
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
}
