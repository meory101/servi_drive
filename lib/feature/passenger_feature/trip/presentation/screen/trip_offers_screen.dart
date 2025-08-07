import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/resource/icon_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/app_bar/main_app_bar.dart';
import 'package:servi_drive/core/widget/container/decorated_container.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/image_manager.dart';
import '../../../../../core/widget/image/main_image_widget.dart';
import '../widget/trip_offers_statistics.dart';
import '../cubit/trip_offers_cubit/trip_offers_cubit.dart';
import '../cubit/trip_offers_cubit/trip_offers_state.dart';
import '../../../../../../core/resource/cubit_status_manager.dart';
import '../../../../../../core/injection/injection_container.dart';
import '../../../../../../core/model/trip_data.dart';

class TripOffersScreen extends StatefulWidget {
  final TripOffersArgs args;
  
  const TripOffersScreen({super.key, required this.args});

  @override
  State<TripOffersScreen> createState() => _TripOffersScreenState();
}

class _TripOffersScreenState extends State<TripOffersScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TripOffersCubit>().getTripOffers(context: context, tripId: widget.args.tripId, isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripOffersCubit>(),
      child: BlocBuilder<TripOffersCubit, TripOffersState>(
        builder: (context, state) {
          return Scaffold(
            appBar: MainAppBar(title: "Trip Offers"),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<TripOffersCubit>().getTripOffers(context: context, tripId: widget.args.tripId, isRefresh: true);
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.all(AppWidthManager.w3Point8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TripOffersStatistics(),
                      Column(
                        children: [
                          SizedBox(
                            height: AppHeightManager.h4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  scrollController.animateTo(AppHeightManager.h35,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.ease);
                                },
                                child: AppTextWidget(
                                  text: "Latest Offers",
                                  fontSize: FontSizeManager.fs17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SvgPicture.asset(
                                AppIconManager.filter,
                                colorFilter: ColorFilter.mode(
                                    AppColorManager.textAppColor, BlendMode.srcIn),
                              )
                            ],
                          ),
                          SizedBox(
                            height: AppHeightManager.h2,
                          ),
                          if (state.status == CubitStatus.loading && state.tripOffers.isEmpty)
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          else if (state.status == CubitStatus.error && state.tripOffers.isEmpty)
                            Center(
                              child: Column(
                                children: [
                                  AppTextWidget(
                                    text: "Error: ${state.error}",
                                    color: Colors.red,
                                  ),
                                  SizedBox(height: AppHeightManager.h2),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<TripOffersCubit>().getTripOffers(context: context, tripId: widget.args.tripId, isRefresh: true);
                                    },
                                    child: AppTextWidget(text: "Retry"),
                                  ),
                                ],
                              ),
                            )
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.tripOffers.length + (state.hasReachedMax ? 0 : 1),
                              itemBuilder: (context, index) {
                                if (index == state.tripOffers.length) {
                                  // Load more indicator
                                  if (!state.hasReachedMax) {
                                    context.read<TripOffersCubit>().loadMoreOffers(context: context, tripId: widget.args.tripId);
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(AppHeightManager.h2),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return SizedBox.shrink();
                                }

                                final tripOffer = state.tripOffers[index];
                                return DecoratedContainer(
                                  margin: EdgeInsets.only(bottom: AppHeightManager.h1point8),
                                  padding: EdgeInsets.all(AppWidthManager.w3Point8),
                                  child: Row(
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        height: AppWidthManager.w14,
                                        width: AppWidthManager.w14,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColorManager.mainGreyColor),
                                        child: MainImageWidget(
                                          imagePath: tripOffer.passengerId?.image ?? AppImageManager.placeholder,
                                        ),
                                      ),
                                      SizedBox(width: AppWidthManager.w1Point8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                AppTextWidget(
                                                  text: tripOffer.passengerId?.fullName ?? "Unknown",
                                                  color: AppColorManager.darkMainColor,
                                                  fontSize: FontSizeManager.fs16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                AppTextWidget(
                                                  text: "\$${tripOffer.budget?.toString() ?? '0'}",
                                                  color: AppColorManager.lightMainColor,
                                                  fontSize: FontSizeManager.fs17,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: AppTextWidget(
                                                    text: tripOffer.routeId?.routeName ?? "Unknown Route",
                                                    color: AppColorManager.textGrey,
                                                    fontSize: FontSizeManager.fs15,
                                                    fontWeight: FontWeight.w500,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: AppHeightManager.h1),
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_today, size: 16, color: AppColorManager.textGrey),
                                                SizedBox(width: AppWidthManager.w1),
                                                AppTextWidget(
                                                  text: tripOffer.tripDate ?? "No date",
                                                  color: AppColorManager.textGrey,
                                                  fontSize: FontSizeManager.fs14,
                                                ),
                                                SizedBox(width: AppWidthManager.w3),
                                                Icon(Icons.access_time, size: 16, color: AppColorManager.textGrey),
                                                SizedBox(width: AppWidthManager.w1),
                                                AppTextWidget(
                                                  text: tripOffer.tripTime ?? "No time",
                                                  color: AppColorManager.textGrey,
                                                  fontSize: FontSizeManager.fs14,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TripOffersArgs {
  final String tripId;
  final TripData? tripData;

  TripOffersArgs({required this.tripId, this.tripData});
}
