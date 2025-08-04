import 'package:dartz/dartz.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/trip_routes_response_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../entity/request/new_trip_request_entity.dart';
import '../repository/trip_repository.dart';

class NewTripUsecase {
  final TripRepository repository;

  NewTripUsecase({required this.repository});

  Future<Either<ApiFailure, bool>> call({required NewTripRequestEntity entity}) async {
    return await repository.makeNewTrip(entity: entity);
  }
}
