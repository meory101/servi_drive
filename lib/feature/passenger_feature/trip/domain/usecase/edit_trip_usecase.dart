import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../../../../core/model/trip_data.dart';
import '../repository/trip_repository.dart';

class EditTripUseCase {
  final TripRepository repository;

  EditTripUseCase({required this.repository});

  Future<Either<ApiFailure, TripData>> call({
    required String tripId,
    required TripData tripData,
  }) async {
    return await repository.editTrip(tripId: tripId, tripData: tripData);
  }
} 