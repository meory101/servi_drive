import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../core/helper/location_helper.dart';
import '../core/theme/app_theme.dart';
import '../router/router.dart';
import 'dart:ui' as ui;
///
/// created by eng hussaen baghdadi ***
/// at 11/5/2025
///

final GlobalKey<NavigatorState> myAppKey = GlobalKey<NavigatorState>();

class ServiDrive extends StatefulWidget {
  const ServiDrive({super.key});

  @override
  State<ServiDrive> createState() => _ServiDriveState();
}

class _ServiDriveState extends State<ServiDrive> {
  bool? _locationGranted;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    final granted = await LocationHelper.requestLocationPermission();
    setState(() {
      _locationGranted = granted;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_locationGranted == null) {
      return const Material(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (!_locationGranted!) {
      return const Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Center(
          child: Text("Location permission is required to use this app."),
        ),
      );
    }
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        theme: lightTheme(),
        navigatorKey: myAppKey,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: RouteNamedScreens.init,
      );
    });
  }
}
