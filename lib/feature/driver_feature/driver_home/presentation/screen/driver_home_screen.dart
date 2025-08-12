import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/widget/empty/empty_widget.dart';
import 'package:servi_drive/core/widget/loading/app_circular_progress_widget.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';
import 'package:servi_drive/feature/driver_feature/driver_home/presentation/cubit/driver_home_cubit.dart';
import 'package:servi_drive/feature/driver_feature/driver_home/presentation/cubit/driver_home_state.dart';
import 'package:servi_drive/feature/passenger_feature/more/presentation/cubit/get_profile_cubit/get_profile_cubit.dart';
import '../../../../passenger_feature/more/presentation/widget/my_trip_card.dart';
import '../widget/driver_home_app_bar.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
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
      context
          .read<DriverHomeCubit>()
          .loadMore(context: context, isUrgent: true, status: const [1, 2]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DriverHomeCubit, DriverHomeState>(
        listener: (context, state) {
          if (state.status == CubitStatus.error) {
            NoteMessage.showErrorSnackBar(
              context: context,
              text: state.error,
            );
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<GetProfileCubit>().getProfile(context: context);
              context
                  .read<DriverHomeCubit>()
                  .refresh(context: context, isUrgent: true, status: const [1]);
            },
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _DriverHomeAppBarDelegate(
                    minExtentHeight: AppHeightManager.h17,
                    maxExtentHeight: AppHeightManager.h17,
                    child: const DriverHomeAppBar(),
                  ),
                ),

                if (state.status == CubitStatus.loading && state.trips.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: AppCircularProgressWidget()),
                  )
                else if (state.trips.isEmpty && state.status == CubitStatus.success)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyWidget()
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == state.trips.length) {
                          if (state.hasReachedMax) return const SizedBox.shrink();
                          return Padding(
                            padding: EdgeInsets.all(AppHeightManager.h2),
                            child: const Center(child: AppCircularProgressWidget()),
                          );
                        }
                        final trip = state.trips[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppWidthManager.w3Point8),
                          child: MyTripCard(
                            trip: trip,
                            isActiveTrip: true,
                          ),
                        );
                      },
                      childCount: state.trips.length + (state.hasReachedMax ? 0 : 1),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DriverHomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minExtentHeight;
  final double maxExtentHeight;
  final Widget child;

  _DriverHomeAppBarDelegate({
    required this.minExtentHeight,
    required this.maxExtentHeight,
    required this.child,
  });

  @override
  double get minExtent => minExtentHeight;

  @override
  double get maxExtent => maxExtentHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _DriverHomeAppBarDelegate oldDelegate) {
    return false;
  }
}
