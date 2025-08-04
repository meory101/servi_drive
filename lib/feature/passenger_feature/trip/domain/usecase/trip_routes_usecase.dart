import 'package:dartz/dartz.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/trip_routes_response_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../repository/trip_repository.dart';

class TripRoutesUsecase {
  final TripRepository repository;

  TripRoutesUsecase({required this.repository});

  Future<Either<ApiFailure, TripRoutesResponseEntity>> call() async {
    return await repository.getTripRoutes();
  }
}
