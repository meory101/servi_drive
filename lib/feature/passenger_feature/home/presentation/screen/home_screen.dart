import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servi_drive/core/resource/size_manager.dart';

import '../../../more/presentation/widget/my_trip_card.dart';
import '../widget/home_app_bar.dart';
import '../widget/home_banners.dart';
import '../widget/new_drivers_section.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          HomeAppBar(),
          SizedBox(
            height: AppHeightManager.h4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
            child: MyTripCard(
              index: 2,
              isActiveTrip: true,
            ),
          ),
          SizedBox(
            height: AppHeightManager.h3,
          ),
          HomeBanners(),
          SizedBox(
            height: AppHeightManager.h3,
          ),
          NewDriversSection()
        ],
      )),
    );
  }
}
