import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../repository/more_repository.dart';
import '../entity/request/edit_profile_request_entity.dart';

class EditProfileUsecase {
  final MoreRepository repository;

  EditProfileUsecase({required this.repository});

  Future<Either<ApiFailure, bool>> call({required EditProfileRequestEntity entity}) async {
    return await repository.editProfile(entity: entity);
  }
} 