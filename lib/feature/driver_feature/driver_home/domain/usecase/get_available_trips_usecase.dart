import 'package:dartz/dartz.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/my_trips_response_entity.dart';
import 'package:servi_drive/core/api/api_error/api_failures.dart';

import '../repository/driver_home_repository.dart';

class GetAvailableTripsUseCase {
  final DriverHomeRepository repository;

  GetAvailableTripsUseCase({required this.repository});

  Future<Either<ApiFailure, MyTripsResponseEntity>> call({
    required bool isUrgent,
    required int page,
    required int limit,
    List<int>? status,
  }) async {
    return await repository.getAvailableTrips(
      isUrgent: isUrgent,
      page: page,
      limit: limit,
      status: status,
    );
  }
}


