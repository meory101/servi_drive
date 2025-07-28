 import 'package:dartz/dartz.dart';
import 'api_error/api_exception.dart';
import 'api_error/api_failures.dart';

class Connector<T> {
   Future<Either<ApiFailure, T>> connect(
      {required Future<Right<ApiFailure, T>> Function() remote,
      Future<Right<ApiFailure, T>> Function()? cache}) async {

    if (true) {
      try {
        return await remote();
      } on ApiServerException catch (error) {
        return Left(ApiServerFailure(response: error.response));
      }
    } else {
      if (cache == null) {
        // return Left(OfflineApiFailure(message: checkConnectionModel.message));
      } else {
        try {
          return await cache();
        } on EmptyApiCacheException {
          return Left(EmptyApiCacheFailure());
        }
      }
    }
  }
}
