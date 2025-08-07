import 'package:dartz/dartz.dart';
import 'package:servi_drive/core/model/trip_data.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/request/new_trip_request_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/conditions_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/trip_routes_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/my_trips_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/trip_offers_response_entity.dart';
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

  @override
  Future<Either<ApiFailure, MyTripsResponseEntity>> getMyTrips({required int page, required int limit}) async {
    return Connector<MyTripsResponseEntity>().connect(
      remote: () async {
        final result = await remote.getMyTrips(page: page, limit: limit);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, TripOffersResponseEntity>> getTripOffers({required int page, required int limit, required String tripId}) async {
    return Connector<TripOffersResponseEntity>().connect(
      remote: () async {
        final result = await remote.getTripOffers(page: page, limit: limit, tripId: tripId);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, TripData>> getTripDetails({required String tripId}) async {
    return Connector<TripData>().connect(
      remote: () async {
        final result = await remote.getTripDetails(tripId: tripId);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<ApiFailure, TripData>> editTrip({required String tripId, required TripData tripData}) async {
    return Connector<TripData>().connect(
      remote: () async {
        final result = await remote.editTrip(tripId: tripId, tripData: tripData);
        return Right(result);
      },
    );
  }
}
