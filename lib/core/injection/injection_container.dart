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

import '../../feature/passenger_feature/auth/data/datasource/remote/auth_remote.dart';
import '../../feature/passenger_feature/auth/data/repository/auth_repository_implements.dart';
import '../../feature/passenger_feature/auth/domain/repository/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => RegisterCubit(usecase: sl()));
  sl.registerFactory(() => LoginCubit(usecase: sl()));
  sl.registerFactory(() => VerifyOtpCubit(usecase: sl()));
  sl.registerFactory(() => ResendOtpCubit(usecase: sl()));

  sl.registerLazySingleton(() => RegisterUsecase(repository: sl()));
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => ResendOtpUsecase(repository: sl()));

  // Services
  sl.registerLazySingleton(() => AuthService(
    registerUsecase: sl(),
    verifyOtpUsecase: sl(),
    resendOtpUsecase: sl(),
  ));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImplements(remote: sl()));

  sl.registerLazySingleton<AuthRemote>(() => AuthRemoteImplement());
}
