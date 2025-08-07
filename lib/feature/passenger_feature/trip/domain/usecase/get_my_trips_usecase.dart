import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../entity/response/my_trips_response_entity.dart';
import '../repository/trip_repository.dart';

class GetMyTripsUseCase {
  final TripRepository repository;

  GetMyTripsUseCase({required this.repository});

  Future<Either<ApiFailure, MyTripsResponseEntity>> call({
    required int page,
    required int limit,
  }) async {
    return await repository.getMyTrips(page: page, limit: limit);
  }
} 