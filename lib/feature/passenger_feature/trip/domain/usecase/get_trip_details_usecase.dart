import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../../../../core/model/trip_data.dart';
import '../repository/trip_repository.dart';

class GetTripDetailsUseCase {
  final TripRepository repository;

  GetTripDetailsUseCase({required this.repository});

  Future<Either<ApiFailure, TripData>> call({
    required String tripId,
  }) async {
    return await repository.getTripDetails(tripId: tripId);
  }
} 