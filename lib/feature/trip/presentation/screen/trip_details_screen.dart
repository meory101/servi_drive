import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servi_drive/core/helper/date_time_helper.dart';
import 'package:servi_drive/core/helper/language_helper.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/resource/enum_manager.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/widget/loading/app_circular_progress_widget.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/icon_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/text/status_text.dart';
import '../cubit/trip_details_cubit/trip_details_cubit.dart';
import '../cubit/trip_details_cubit/trip_details_state.dart';
import '../widget/new_trip_map.dart';
import '../widget/trip_details_bottom_sheet.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripDetailsCubit, TripDetailsState>(
      listener: (context, state) {
        if (state.status == CubitStatus.error) {
          NoteMessage.showErrorSnackBar(
            context: context,
            text: state.error,
          );
        }
      },
      builder: (context, state) {
        if (state.status == CubitStatus.loading) {
          return Scaffold(
            body: Center(
              child: AppCircularProgressWidget(),
            ),
          );
        }

        if (state.status == CubitStatus.error || state.trip == null) {
          return Scaffold(
            body: Center(
              child: AppTextWidget(
                text: state.error.isEmpty ? "Trip not found" : state.error,
                color: AppColorManager.red,
                fontSize: FontSizeManager.fs16,
              ),
            ),
          );
        }

        final trip = state.trip!;

        if (trip.conditions != null) {
          for (var i = 0; i < trip.conditions!.length; i++) {
          }
        }

        return Scaffold(
          body: Stack(children: [
            SizedBox(
              height: AppHeightManager.h100,
              width: AppWidthManager.w100,
              child: NewTripMap(
                isReadOnly: true,
                fromLocation: LatLng((trip.fromLat ?? 0).toDouble(),
                    (trip.fromLng ?? 0).toDouble()),
                toLocation: LatLng(
                    (trip.toLat ?? 0).toDouble(), (trip.toLng ?? 0).toDouble()),
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: AppHeightManager.h8,
                    right: !LanguageHelper.checkIfLTR(context: context)
                        ? AppWidthManager.w2
                        : 0,
                    left: LanguageHelper.checkIfLTR(context: context)
                        ? AppWidthManager.w2
                        : 0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColorManager.lightMainColor,
                    child: SvgPicture.asset(
                      LanguageHelper.checkIfLTR(context: context)
                          ? AppIconManager.arrowMenuLeft
                          : AppIconManager.arrowMenuRight,
                      colorFilter: ColorFilter.mode(
                          AppColorManager.white, BlendMode.srcIn),
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height ,
                ),
                decoration: BoxDecoration(
                  color: AppColorManager.darkMainColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppRadiusManager.r20),
                    topRight: Radius.circular(AppRadiusManager.r20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppWidthManager.w3Point8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppHeightManager.h3),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppTextWidget(
                              text: trip.routeId?.routeName ?? "",
                              color: AppColorManager.white,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSizeManager.fs17,
                            ),
                          ),
                          SizedBox(width: AppWidthManager.w2),
                          AppTextWidget(
                            text: "\$${trip.budget ?? 0}",
                            color: AppColorManager.lightMainColor,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSizeManager.fs17,
                          ),
                        ],
                      ),

                      SizedBox(height: AppHeightManager.h2),

                      if (trip.routeId?.routeName != null &&
                          trip.routeId!.routeName!.isNotEmpty)
                        AppTextWidget(
                          text: trip.routeId!.routeName!,
                          color: AppColorManager.mainGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: FontSizeManager.fs15,
                        ),

                      SizedBox(height: AppHeightManager.h3),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: StatusText(
                              color:
                                  EnumManager.getTripStatusColor(trip.status),
                              text: EnumManager.getTripStatusText(trip.status),
                            ),
                          ),
                          SizedBox(width: AppWidthManager.w2),
                          Flexible(
                            child: AppTextWidget(
                              text:
                                  "${DateTimeHelper.formatDateWithSlashBasedOnLang(date: trip.tripDate ?? "")} ${trip.tripTime ?? ''}",
                              fontWeight: FontWeight.w500,
                              fontSize: FontSizeManager.fs15,
                              color: AppColorManager.textGrey,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: AppHeightManager.h3),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text:
                                    "${trip.numberOfTravelers ?? 0} Travellers",
                                fontWeight: FontWeight.w600,
                                fontSize: FontSizeManager.fs16,
                                color: AppColorManager.white,
                              ),
                              SizedBox(width: AppWidthManager.w1),
                              SizedBox(
                                height: AppHeightManager.h2point5,
                                width: AppHeightManager.h2point5,
                                child: SvgPicture.asset(
                                  AppIconManager.person,
                                  color: AppColorManager.white,
                                ),
                              ),
                            ],
                          ),
                          if ((trip.luggageCount ?? 0) != 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AppTextWidget(
                                  text: "${trip.luggageCount ?? 0} Luggage",
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSizeManager.fs16,
                                  color: AppColorManager.white,
                                ),
                                SizedBox(width: AppWidthManager.w1),
                                Icon(
                                  Icons.shopping_bag,
                                  color: AppColorManager.white,
                                  size: AppHeightManager.h2point5,
                                ),
                              ],
                            ),
                        ],
                      ),

                      if (trip.conditions != null &&
                          trip.conditions!.isNotEmpty) ...[
                        SizedBox(height: AppHeightManager.h4),
                        AppTextWidget(
                          text: "Conditions",
                          color: AppColorManager.white,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSizeManager.fs16,
                        ),
                        SizedBox(height: AppHeightManager.h2),
                        ...trip.conditions!.map((condition) => Padding(
                              padding:
                                  EdgeInsets.only(bottom: AppHeightManager.h2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Expanded(
                                    child: AppTextWidget(
                                      text: condition,
                                      color: AppColorManager.grey,
                                      fontSize: FontSizeManager.fs16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],

                      SizedBox(height: AppHeightManager.h4),

                      TripDetailsBottomSheet(
                        tripData: trip,
                      ),

                      SizedBox(height: AppHeightManager.h6),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
