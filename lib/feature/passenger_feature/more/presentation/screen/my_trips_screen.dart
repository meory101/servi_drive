import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/app_bar/main_app_bar.dart';

import '../widget/my_trip_card.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(title: "My Trips".tr()),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 4,
            itemBuilder: (context, index) {
              return MyTripCard(index: index);
            },
          ),
        ));
  }
}
