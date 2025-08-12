import 'package:servi_drive/feature/passenger_feature/trip/domain/entity/response/my_trips_response_entity.dart';
import 'package:servi_drive/core/api/api_error/api_exception.dart';
import 'package:servi_drive/core/api/api_error/api_status_code.dart';
import 'package:servi_drive/core/api/api_links.dart';
import 'package:servi_drive/core/api/api_methods.dart';

abstract class DriverHomeRemote {
  Future<MyTripsResponseEntity> getAvailableTrips({
    required bool isUrgent,
    required int page,
    required int limit,
    List<int>? status,
  });
}

class DriverHomeRemoteImplement extends DriverHomeRemote {
  @override
  Future<MyTripsResponseEntity> getAvailableTrips({
    required bool isUrgent,
    required int page,
    required int limit,
    List<int>? status,
  }) async {
    final String base = ApiGetUrl.availableTrips;

    final uri = '$base?isUrgent=$isUrgent&page=$page&limit=$limit'
        '${status != null && status.isNotEmpty ? status.map((s) => '&status=$s').join('') : ''}';

    final response = await ApiMethods().get(url: uri);

    if (ApiStatusCode.success().contains(response.statusCode)) {
      return myTripsResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }
}


