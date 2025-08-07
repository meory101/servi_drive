import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../../../../core/model/trip_data.dart';
import '../entity/request/new_trip_request_entity.dart';
import '../entity/response/conditions_response_entity.dart';
import '../entity/response/trip_routes_response_entity.dart';
import '../entity/response/my_trips_response_entity.dart';

///
/// created by eng nour othman ***
/// at 23/2/2025
///
abstract class TripRepository {

  Future<Either<ApiFailure,TripRoutesResponseEntity>> getTripRoutes();
  Future<Either<ApiFailure,PreferredConditionsResponseEntity>> getConditions();
  Future<Either<ApiFailure,bool>> makeNewTrip({required NewTripRequestEntity entity});
  Future<Either<ApiFailure,MyTripsResponseEntity>> getMyTrips({required int page, required int limit});
  Future<Either<ApiFailure,TripData>> getTripDetails({required String tripId});

}
