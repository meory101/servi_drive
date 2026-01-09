import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../repository/more_repository.dart';
import '../entity/response/profile_response_entity.dart';

class GetProfileUsecase {
  final MoreRepository repository;

  GetProfileUsecase({required this.repository});

  Future<Either<ApiFailure, ProfileResponseEntity>> call() async {
    return await repository.getProfile();
  }
} 