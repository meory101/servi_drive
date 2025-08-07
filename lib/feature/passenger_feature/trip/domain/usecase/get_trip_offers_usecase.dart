import 'package:dartz/dartz.dart';
import '../../../../../core/api/api_error/api_failures.dart';
import '../../domain/repository/trip_repository.dart';
import '../entity/response/trip_offers_response_entity.dart';

class GetTripOffersUseCase {
  final TripRepository repository;

  GetTripOffersUseCase({required this.repository});

  Future<Either<ApiFailure, TripOffersResponseEntity>> call({
    required int page,
    required int limit,
    required String tripId,
  }) async {
    return await repository.getTripOffers(page: page, limit: limit, tripId: tripId);
  }
} 