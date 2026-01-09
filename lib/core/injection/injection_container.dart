
import 'package:get_it/get_it.dart';

import '../../feature/auth/data/datasource/remote/auth_remote.dart';
import '../../feature/auth/data/repository/auth_repository_implements.dart';
import '../../feature/auth/domain/repository/auth_repository.dart';
import '../../feature/auth/domain/usecase/auth_service.dart';
import '../../feature/auth/domain/usecase/forgot_password_usecase.dart';
import '../../feature/auth/domain/usecase/login_usecase.dart';
import '../../feature/auth/domain/usecase/register_usecase.dart';
import '../../feature/auth/domain/usecase/resend_otp_usecase.dart';
import '../../feature/auth/domain/usecase/reset_password_usecase.dart';
import '../../feature/auth/domain/usecase/verify_otp_usecase.dart';
import '../../feature/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import '../../feature/auth/presentation/cubit/login/login_cubit.dart';
import '../../feature/auth/presentation/cubit/register_cubit/register_cubit.dart';
import '../../feature/auth/presentation/cubit/resend_otp_cubit/resend_otp_cubit.dart';
import '../../feature/auth/presentation/cubit/reset_password_cubit/reset_password_cubit.dart';
import '../../feature/auth/presentation/cubit/verfiy_otp_cubit/verfiy_otp_cubit.dart';
import '../../feature/more/data/datasource/remote/more_remote.dart';
import '../../feature/more/data/repository/more_repository_implements.dart';
import '../../feature/more/domain/repository/more_repository.dart';
import '../../feature/more/domain/usecase/edit_profile_usecase.dart';
import '../../feature/more/domain/usecase/get_profile_usecase.dart';
import '../../feature/more/domain/usecase/upload_profile_image_usecase.dart';
import '../../feature/more/presentation/cubit/edit_profile_cubit/edit_profile_cubit.dart';
import '../../feature/more/presentation/cubit/get_profile_cubit/get_profile_cubit.dart';
import '../../feature/more/presentation/cubit/upload_profile_image_cubit/upload_profile_image_cubit.dart';
import '../../feature/trip/data/datasource/remote/trip_remote.dart';
import '../../feature/trip/data/repository/trip_repository_implements.dart';
import '../../feature/trip/domain/repository/trip_repository.dart';
import '../../feature/trip/domain/usecase/conditions_usecase.dart';
import '../../feature/trip/domain/usecase/edit_trip_usecase.dart';
import '../../feature/trip/domain/usecase/get_my_trips_usecase.dart';
import '../../feature/trip/domain/usecase/get_trip_details_usecase.dart';
import '../../feature/trip/domain/usecase/get_trip_offers_usecase.dart';
import '../../feature/trip/domain/usecase/new_trip_usecase.dart';
import '../../feature/trip/domain/usecase/trip_routes_usecase.dart';
import '../../feature/trip/presentation/cubit/conditions_cubit/conditions_cubit.dart';
import '../../feature/trip/presentation/cubit/edit_trip_cubit/edit_trip_cubit.dart';
import '../../feature/trip/presentation/cubit/my_trips_cubit/my_trips_cubit.dart';
import '../../feature/trip/presentation/cubit/new_trip_cubit/new_trip_cubit.dart';
import '../../feature/trip/presentation/cubit/trip_details_cubit/trip_details_cubit.dart';
import '../../feature/trip/presentation/cubit/trip_offers_cubit/trip_offers_cubit.dart';
import '../../feature/trip/presentation/cubit/trip_routes_cubit/trip_routes_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => RegisterCubit(usecase: sl()));
  sl.registerFactory(() => LoginCubit(usecase: sl()));
  sl.registerFactory(() => VerifyOtpCubit(usecase: sl()));
  sl.registerFactory(() => ResendOtpCubit(usecase: sl()));
  sl.registerFactory(() => ForgotPasswordCubit(usecase: sl()));
  sl.registerFactory(() => ResetPasswordCubit(usecase: sl()));
  sl.registerFactory(() => GetProfileCubit(usecase: sl()));
  sl.registerFactory(() => UploadProfileImageCubit(usecase: sl()));
  sl.registerFactory(() => EditProfileCubit(usecase: sl()));
  sl.registerFactory(() => ConditionsCubit(usecase: sl()));
  sl.registerFactory(() => TripRoutesCubit(usecase: sl()));
  sl.registerFactory(() => NewTripCubit(usecase: sl()));
  sl.registerFactory(() => MyTripsCubit(usecase: sl()));
  sl.registerFactory(() => TripOffersCubit(usecase: sl()));
  sl.registerFactory(() => TripDetailsCubit(usecase: sl()));
  sl.registerFactory(() => EditTripCubit(usecase: sl()));

  sl.registerLazySingleton(() => RegisterUsecase(repository: sl()));
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => ResendOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => ForgotPasswordUsecase(repository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetProfileUsecase(repository: sl()));
  sl.registerLazySingleton(() => UploadProfileImageUsecase(repository: sl()));
  sl.registerLazySingleton(() => EditProfileUsecase(repository: sl()));
  sl.registerLazySingleton(() => TripRoutesUsecase(repository: sl()));
  sl.registerLazySingleton(() => ConditionsUsecase(repository: sl()));
  sl.registerLazySingleton(() => NewTripUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetMyTripsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTripOffersUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTripDetailsUseCase(repository: sl()));
  sl.registerLazySingleton(() => EditTripUseCase(repository: sl()));

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

  sl.registerLazySingleton<MoreRepository>(
      () => MoreRepositoryImplements(remote: sl()));

  sl.registerLazySingleton<AuthRemote>(() => AuthRemoteImplement());
  sl.registerLazySingleton<TripRemote>(() => TripRemoteImplement());
  sl.registerLazySingleton<MoreRemote>(() => MoreRemoteImplement());
}
