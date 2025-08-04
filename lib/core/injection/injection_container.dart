import 'package:get_it/get_it.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/usecase/login_usecase.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/usecase/register_usecase.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/usecase/verify_otp_usecase.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/usecase/resend_otp_usecase.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/usecase/auth_service.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/login/login_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/verfiy_otp_cubit/verfiy_otp_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/resend_otp_cubit/resend_otp_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/trip/data/datasource/remote/trip_remote.dart';
import 'package:servi_drive/feature/passenger_feature/trip/data/repository/trip_repository_implements.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/repository/trip_repository.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/usecase/conditions_usecase.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/usecase/new_trip_usecase.dart';
import 'package:servi_drive/feature/passenger_feature/trip/domain/usecase/trip_routes_usecase.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/conditions_cubit/conditions_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/new_trip_cubit/new_trip_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/trip_routes_cubit/trip_routes_cubit.dart';

import '../../feature/passenger_feature/auth/data/datasource/remote/auth_remote.dart';
import '../../feature/passenger_feature/auth/data/repository/auth_repository_implements.dart';
import '../../feature/passenger_feature/auth/domain/repository/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => RegisterCubit(usecase: sl()));
  sl.registerFactory(() => LoginCubit(usecase: sl()));
  sl.registerFactory(() => VerifyOtpCubit(usecase: sl()));
  sl.registerFactory(() => ResendOtpCubit(usecase: sl()));
  sl.registerFactory(() => ConditionsCubit(usecase: sl()));
  sl.registerFactory(() => TripRoutesCubit(usecase: sl()));
  sl.registerFactory(() => NewTripCubit(usecase: sl()));

  sl.registerLazySingleton(() => RegisterUsecase(repository: sl()));
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => ResendOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => TripRoutesUsecase(repository: sl()));
  sl.registerLazySingleton(() => ConditionsUsecase(repository: sl()));
  sl.registerLazySingleton(() => NewTripUsecase(repository: sl()));

  // Services
  sl.registerLazySingleton(() => AuthService(
    registerUsecase: sl(),
    verifyOtpUsecase: sl(),
    resendOtpUsecase: sl(),
  ));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImplements(remote: sl()));

  sl.registerLazySingleton<TripRepository>(
          () => TripRepositoryImplements(remote: sl()));


  sl.registerLazySingleton<AuthRemote>(() => AuthRemoteImplement());
  sl.registerLazySingleton<TripRemote>(() => TripRemoteImplement());
}
