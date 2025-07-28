import 'package:servi_drive/core/storage/shared/shared_pref.dart';
import 'package:servi_drive/router/router.dart';
import 'package:flutter/cupertino.dart';

abstract class ApiErrorMethod {
  static void invalidSessionToken({required BuildContext context}) {
    AppSharedPreferences.cashToken(token: "");

    AppSharedPreferences.clear();
    // Navigator.of(context).pushNamedAndRemoveUntil(
    //   RouteNamedScreens.login,
    //   (route) => false,
    // );
  }
}
