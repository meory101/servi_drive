import 'package:dartz/dartz.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/my_trips_response_entity.dart';
import 'package:servi_drive/core/api/api_error/api_failures.dart';

abstract class DriverHomeRepository {
  Future<Either<ApiFailure, MyTripsResponseEntity>> getAvailableTrips({
    required bool isUrgent,
    required int page,
    required int limit,
    List<int>? status,
  });
}


