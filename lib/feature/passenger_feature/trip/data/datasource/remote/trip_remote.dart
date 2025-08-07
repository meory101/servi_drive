
import 'package:servi_drive/core/model/trip_data.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/conditions_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/trip_routes_response_entity.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/my_trips_response_entity.dart';
import '../../../../../../core/api/api_error/api_exception.dart';
import '../../../../../../core/api/api_error/api_status_code.dart';
import '../../../../../../core/api/api_links.dart';
import '../../../../../../core/api/api_methods.dart';
import '../../../domain/entity/request/new_trip_request_entity.dart';


///
/// created by eng nour othman ***
/// at 23/2/2025
///

abstract class TripRemote {
  Future<TripRoutesResponseEntity> getTripRoutes();
  Future<PreferredConditionsResponseEntity> getConditions();
  Future<bool> makeNewTrip({required NewTripRequestEntity entity});
  Future<MyTripsResponseEntity> getMyTrips({required int page, required int limit});
  Future<TripData> getTripDetails({required String tripId});


}

class TripRemoteImplement extends TripRemote {

  @override
  Future<TripRoutesResponseEntity> getTripRoutes() async{
    final response =
        await ApiMethods().get(url: ApiGetUrl.tripRoutes,);

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return tripRoutesResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<PreferredConditionsResponseEntity> getConditions()async {
    final response =
    await ApiMethods().get(url: ApiGetUrl.conditions,);

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return preferredConditionsResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<bool> makeNewTrip({required NewTripRequestEntity entity}) async{
    final response =
    await ApiMethods().post(url: ApiPostUrl.createTrip,body: entity.toJson());

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return true;
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<MyTripsResponseEntity> getMyTrips({required int page, required int limit}) async {
    final response = await ApiMethods().get(
      url: '${ApiGetUrl.myTrips}?page=$page&limit=$limit',
    );

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return myTripsResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  @override
  Future<TripData> getTripDetails({required String tripId}) async {
    final response = await ApiMethods().get(
      url: '${ApiGetUrl.tripDetails}/$tripId',
    );

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return tripDataFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }
}
