import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/core/navigation/slid_left_builder_route.dart';
import 'package:servi_drive/core/storage/shared/shared_pref.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/login/login_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/resend_otp_cubit/resend_otp_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/reset_password_cubit/reset_password_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/verfiy_otp_cubit/verfiy_otp_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/screen/auth_intro_screen.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/screen/number_resend_code_screen.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/screen/number_reset_password_screen.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/screen/register_screen.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/screen/verification_code_screen.dart';
import 'package:servi_drive/feature/passenger_feature/more/presentation/screen/my_trips_screen.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/conditions_cubit/conditions_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/new_trip_cubit/new_trip_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/trip_routes_cubit/trip_routes_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/screen/driver_info_screen.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/screen/trip_details_screen.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/screen/trip_offers_screen.dart';

import '../core/navigation/fade_builder_route.dart';
import '../core/navigation/slid_up_builder_route.dart';
import '../feature/passenger_feature/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import '../feature/passenger_feature/auth/presentation/screen/login_screen.dart';
import '../feature/passenger_feature/auth/presentation/screen/reset_password_screen.dart';
import '../feature/passenger_feature/main/presentation/screen/main_bottom_app_bar.dart';
import '../core/injection/injection_container.dart' as di;

abstract class RouteNamedScreens {
  static String init = authIntro;
  static const String main = "/main-bottom-app-bar";
  static const String myTrips = "/my-trips";
  static const String tripDetails = "/trip-details";
  static const String tripOffers = "/trip-offers";
  static const String driverInfo = "/driver-info";
  static const String register = "/register";
  static const String login = "/login";
  static const String authIntro = "/auth-intro";
  static const String numberResendCodeScreen = "/number-resend-code";
  static const String numberResetPasswordScreen = "/number-reset-password";
  static const String verificationCode = "/verification-code";
  static const String resetPassword = "/reset-password";
}

abstract class AppRouter {
  // ignore: body_might_complete_normally_nullable
  static Route? onGenerateRoute(RouteSettings settings) {
    print(AppSharedPreferences.getToken());
    print('---------------------------------------------------');
    final argument = settings.arguments;
    switch (settings.name) {
      case RouteNamedScreens.main:
        CurrentRoute.currentRouteName = RouteNamedScreens.main;
        return FadeBuilderRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                di.sl<TripRoutesCubit>()
                  ..getTripRoutes(context: context),
              ),
              BlocProvider(
                create: (context) =>
                di.sl<ConditionsCubit>()
                  ..getConditions(context: context),
              ),
              BlocProvider(
                create: (context) =>
                    di.sl<NewTripCubit>(),
              )
            ],
            child: MainAppBottomAppBar(),
          ),
        );
      case RouteNamedScreens.myTrips:
        CurrentRoute.currentRouteName = RouteNamedScreens.myTrips;
        return FadeBuilderRoute(
          page: MyTripsScreen(),
        );


      case RouteNamedScreens.numberResendCodeScreen:
        CurrentRoute.currentRouteName =
            RouteNamedScreens.numberResendCodeScreen;
        return FadeBuilderRoute(
          page: BlocProvider(
            create: (context) => di.sl<ResendOtpCubit>(),
            child: NumberResendCodeScreen(),
          ),
        );

      case RouteNamedScreens.numberResetPasswordScreen:
        CurrentRoute.currentRouteName =
            RouteNamedScreens.numberResetPasswordScreen;
        return FadeBuilderRoute(
          page: BlocProvider(
            create: (context) => di.sl<ForgotPasswordCubit>(),
            child: NumberResetPasswordScreen(),
          ),
        );
      case RouteNamedScreens.resetPassword:
        argument as ResetPasswordArgs;
        CurrentRoute.currentRouteName =
            RouteNamedScreens.resetPassword;
        return FadeBuilderRoute(
          page: BlocProvider(
            create: (context) => di.sl<ResetPasswordCubit>(),
            child: ResetPasswordScreen(
              args: argument,
            ),
          ),
        );
      case RouteNamedScreens.driverInfo:
        CurrentRoute.currentRouteName = RouteNamedScreens.driverInfo;
        return FadeBuilderRoute(
          page: DriverInfoScreen(),
        );
      case RouteNamedScreens.tripDetails:
        CurrentRoute.currentRouteName = RouteNamedScreens.tripDetails;
        return FadeBuilderRoute(
          page: TripDetailsScreen(),
        );

      case RouteNamedScreens.register:
        CurrentRoute.currentRouteName = RouteNamedScreens.register;
        return SlidLeftBuilderRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => di.sl<RegisterCubit>()),
            ],
            child: RegisterScreen(),
          ),
        );
      case RouteNamedScreens.verificationCode:
        argument as VerificationCodeArgs;
        CurrentRoute.currentRouteName = RouteNamedScreens.verificationCode;
        return SlidUpBuilderRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => di.sl<VerifyOtpCubit>(),
              )
            ],
            child: VerificationCodeScreen(args: argument),
          ),
        );
      case RouteNamedScreens.login:
        CurrentRoute.currentRouteName = RouteNamedScreens.login;
        return SlidLeftBuilderRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => di.sl<LoginCubit>(),
              )
            ],
            child: LoginScreen(),
          ),
        );

      case RouteNamedScreens.tripOffers:
        CurrentRoute.currentRouteName = RouteNamedScreens.tripOffers;
        return FadeBuilderRoute(
          page: TripOffersScreen(),
        );

      case RouteNamedScreens.authIntro:
        CurrentRoute.currentRouteName = RouteNamedScreens.authIntro;
        return FadeBuilderRoute(
          page: AuthIntroScreen(),
        );
    }
    return SlidUpBuilderRoute(page: Scaffold());
  }
}

abstract class CurrentRoute {
  static String? currentRouteName;

  CurrentRoute({required String currentRouteName});
}
