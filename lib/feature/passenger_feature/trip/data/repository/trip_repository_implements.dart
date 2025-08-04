import 'package:dartz/dartz.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/request/new_trip_request_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/conditions_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/trip_routes_response_entity.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../../../../core/api/connector.dart';
import '../../domain/repository/trip_repository.dart';
import '../datasource/remote/trip_remote.dart';

class TripRepositoryImplements implements TripRepository {
  final TripRemote remote;

  TripRepositoryImplements({
    required this.remote,
  });


  @override
  Future<Either<ApiFailure, TripRoutesResponseEntity>> getTripRoutes() {
    return Connector<TripRoutesResponseEntity>().connect(
      remote: () async {
        final result = await remote.getTripRoutes();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, PreferredConditionsResponseEntity>> getConditions() async{
    return Connector<PreferredConditionsResponseEntity>().connect(
      remote: () async {
        final result = await remote.getConditions();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, bool>> makeNewTrip({required NewTripRequestEntity entity})async {
    return Connector<bool>().connect(
      remote: () async {
        final result = await remote.makeNewTrip(entity: entity);
        return Right(result);
      },
    );
  }
}
