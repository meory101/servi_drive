import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../entity/response/conditions_response_entity.dart';
import '../repository/trip_repository.dart';

class ConditionsUsecase {
  final TripRepository repository;

  ConditionsUsecase({required this.repository});

  Future<Either<ApiFailure, PreferredConditionsResponseEntity>> call() async {
    return await repository.getConditions();
  }
}
