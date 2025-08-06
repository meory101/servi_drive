import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../repository/more_repository.dart';
import '../entity/request/upload_profile_image_request_entity.dart';

class UploadProfileImageUsecase {
  final MoreRepository repository;

  UploadProfileImageUsecase({required this.repository});

  Future<Either<ApiFailure, bool>> call({required UploadProfileImageRequestEntity entity}) async {
    return await repository.uploadProfileImage(entity: entity);
  }
} 