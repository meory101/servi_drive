import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/core/model/trip_data.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/feature/passenger_feature/more/presentation/cubit/get_profile_cubit/get_profile_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/more/presentation/cubit/get_profile_cubit/get_profile_state.dart';

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
      body: RefreshIndicator(
        onRefresh: () async{
          context.read<GetProfileCubit>().getProfile(context: context);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
            child: Column(
          children: [
            HomeAppBar(),
            SizedBox(
              height: AppHeightManager.h4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
              child: MyTripCard(
                trip: TripData(),
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
      ),
    );
  }
}
