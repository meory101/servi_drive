
import 'package:servi_drive/core/model/trip_data.dart';
import '../../../../../../core/api/api_error/api_exception.dart';
import '../../../../../../core/api/api_error/api_status_code.dart';
import '../../../../../../core/api/api_links.dart';
import '../../../../../../core/api/api_methods.dart';
import '../../../domain/entity/request/new_trip_request_entity.dart';
import '../../../domain/entity/response/conditions_response_entity.dart';
import '../../../domain/entity/response/my_trips_response_entity.dart';
import '../../../domain/entity/response/trip_offers_response_entity.dart';
import '../../../domain/entity/response/trip_routes_response_entity.dart';


///
/// created by eng nour othman ***
/// at 23/2/2025
///

abstract class TripRemote {
  Future<TripRoutesResponseEntity> getTripRoutes();
  Future<PreferredConditionsResponseEntity> getConditions();
  Future<bool> makeNewTrip({required NewTripRequestEntity entity});
  Future<MyTripsResponseEntity> getMyTrips({required int page, required int limit});
  Future<TripOffersResponseEntity> getTripOffers({required int page, required int limit, required String tripId});
  Future<TripData> getTripDetails({required String tripId});
  Future<TripData> editTrip({required String tripId, required TripData tripData});


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
  Future<TripOffersResponseEntity> getTripOffers({required int page, required int limit, required String tripId}) async {
    final response = await ApiMethods().get(
      url: '${ApiGetUrl.tripOffers}?page=$page&limit=$limit&tripId=$tripId',
    );

    print(response.body);
    print('----------------------------------0');

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return tripOffersResponseEntityFromJson(response.body);
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

  @override
  Future<TripData> editTrip({required String tripId, required TripData tripData}) async {
    final response = await ApiMethods().patch(
      url: '${ApiGetUrl.editTrip}/$tripId',
      body: tripData.toJson(),
      query: {},
    );

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return tripDataFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }
}
