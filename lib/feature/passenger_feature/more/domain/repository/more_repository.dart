import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../entity/response/profile_response_entity.dart';
import '../entity/request/upload_profile_image_request_entity.dart';
import '../entity/request/edit_profile_request_entity.dart';

///
/// created by eng nour othman ***
/// at 23/2/2025
///
abstract class MoreRepository {
  Future<Either<ApiFailure, ProfileResponseEntity>> getProfile();
  Future<Either<ApiFailure, bool>> uploadProfileImage({required UploadProfileImageRequestEntity entity});
  Future<Either<ApiFailure, bool>> editProfile({required EditProfileRequestEntity entity});
}
