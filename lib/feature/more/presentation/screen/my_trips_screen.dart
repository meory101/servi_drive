import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/app_bar/main_app_bar.dart';
import 'package:servi_drive/core/widget/loading/app_circular_progress_widget.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';

import '../../../trip/presentation/cubit/my_trips_cubit/my_trips_cubit.dart';
import '../../../trip/presentation/cubit/my_trips_cubit/my_trips_state.dart';
import '../widget/my_trip_card.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      context.read<MyTripsCubit>().loadMoreTrips(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: MainAppBar(title: "My Trips".tr()),
        body: BlocConsumer<MyTripsCubit, MyTripsState>(
          listener: (context, state) {
            if (state.status == CubitStatus.error) {
              NoteMessage.showErrorSnackBar(
                context: context,
                text: state.error,
              );
            }
          },
          builder: (context, state) {
            if (state.status == CubitStatus.loading && state.trips.isEmpty) {
              return const Center(
                child: AppCircularProgressWidget(),
              );
            }

            if (state.trips.isEmpty && state.status == CubitStatus.success) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_car_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: AppHeightManager.h2),
                    Text(
                      "No trips found".tr(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }

            final showBottomLoader = state.status == CubitStatus.loading &&
                state.trips.isNotEmpty &&
                !state.hasReachedMax;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<MyTripsCubit>().refreshTrips(context: context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: state.trips.length + (showBottomLoader ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.trips.length && showBottomLoader) {
                      return Padding(
                        padding: EdgeInsets.all(AppHeightManager.h2),
                        child: const Center(
                          child: AppCircularProgressWidget(),
                        ),
                      );
                    }

                    final trip = state.trips[index];
                    return MyTripCard(trip: trip);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
