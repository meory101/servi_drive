import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../../../../core/api/connector.dart';
import '../../domain/repository/more_repository.dart';
import '../../domain/entity/response/profile_response_entity.dart';
import '../../domain/entity/request/upload_profile_image_request_entity.dart';
import '../../domain/entity/request/edit_profile_request_entity.dart';
import '../datasource/remote/more_remote.dart';

class MoreRepositoryImplements implements MoreRepository {
  final MoreRemote remote;

  MoreRepositoryImplements({
    required this.remote,
  });

  @override
  Future<Either<ApiFailure, ProfileResponseEntity>> getProfile() async {
    return Connector<ProfileResponseEntity>().connect(
      remote: () async {
        final result = await remote.getProfile();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> uploadProfileImage({required UploadProfileImageRequestEntity entity}) async {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.uploadProfileImage(entity: entity);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> editProfile({required EditProfileRequestEntity entity}) async {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.editProfile(entity: entity);
        return Right(result);
      },
    );
  }
}
