import 'package:dartz/dartz.dart';
import 'package:servi_drive/feature/driver_feature/driver_home/data/datasource/driver_home_remote.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/my_trips_response_entity.dart';
import 'package:servi_drive/core/api/api_error/api_failures.dart';
import 'package:servi_drive/core/api/connector.dart';

import '../../domain/repository/driver_home_repository.dart';

class DriverHomeRepositoryImplements implements DriverHomeRepository {
  final DriverHomeRemote remote;

  DriverHomeRepositoryImplements({required this.remote});

  @override
  Future<Either<ApiFailure, MyTripsResponseEntity>> getAvailableTrips({
    required bool isUrgent,
    required int page,
    required int limit,
    List<int>? status,
  }) {
    return Connector<MyTripsResponseEntity>().connect(
      remote: () async {
        final result = await remote.getAvailableTrips(
          isUrgent: isUrgent,
          page: page,
          limit: limit,
          status: status,
        );
        return Right(result);
      },
    );
  }
}


