import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servi_drive/core/helper/language_helper.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/widget/trip_details_bottom_sheet.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/icon_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/text/status_text.dart';
import '../widget/new_trip_map.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: AppHeightManager.h100,
            width: AppWidthManager.w100,
            child: NewTripMap(
              isReadOnly: true,
              fromLocation: LatLng(36.44, 37.5555),
              toLocation: LatLng(33.44, 33.5555),
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
                onTap:() {
                  Navigator.of(context).pop();
                } ,
                child: CircleAvatar(
                  backgroundColor: AppColorManager.lightMainColor,
                  child: SvgPicture.asset(
                    LanguageHelper.checkIfLTR(context: context)
                        ? AppIconManager.arrowMenuLeft
                        : AppIconManager.arrowMenuRight,
                    colorFilter:
                        ColorFilter.mode(AppColorManager.white, BlendMode.srcIn),
                  ),
                ),
              )),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.6,
            snapAnimationDuration: Duration(seconds: 3),
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: AppColorManager.darkMainColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppRadiusManager.r20),
                      topRight: Radius.circular(AppRadiusManager.r20),
                    )),
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppWidthManager.w3Point8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppHeightManager.h3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextWidget(
                              text: "Damascus-Amman",
                              color: AppColorManager.white,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSizeManager.fs17,
                            ),
                            AppTextWidget(
                              text: "200\$",
                              color: AppColorManager.lightMainColor,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSizeManager.fs17,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppHeightManager.h1point8,
                        ),
                        AppTextWidget(
                          text:
                              "Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist Desc If exist",
                          color: AppColorManager.mainGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: FontSizeManager.fs15,
                          maxLines: 10,
                        ),
                        SizedBox(
                          height: AppHeightManager.h1point8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                StatusText(
                                    color: AppColorManager.blue,
                                    text: "Active Trip"),
                              ],
                            ),
                            SizedBox(
                              width: AppWidthManager.w1,
                            ),
                            Row(
                              children: [
                                AppTextWidget(
                                  text: "2/3/2025 1:20 AM",
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSizeManager.fs15,
                                  color: AppColorManager.textGrey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppHeightManager.h1point8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SvgPicture.asset(AppIconManager.calendar),
                                AppTextWidget(
                                  text: "3 Travellers",
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSizeManager.fs16,
                                  color: AppColorManager.white,
                                ),
                                SizedBox(
                                    height: AppHeightManager.h2point5,
                                    width: AppHeightManager.h2point5,
                                    child: SvgPicture.asset(
                                      AppIconManager.person,
                                      color: AppColorManager.white,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SvgPicture.asset(AppIconManager.calendar),
                                AppTextWidget(
                                  text: "2 Luggage ",
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSizeManager.fs16,
                                  color: AppColorManager.white,
                                ),
                                Icon(
                                  Icons.shopping_bag,
                                  color: AppColorManager.white,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppHeightManager.h6point6,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    height: AppHeightManager.h3,
                                    width: AppHeightManager.h3,
                                    child: SvgPicture.asset(
                                      AppIconManager.noSmoke,
                                      color: AppColorManager.white,
                                    )),
                                SizedBox(
                                  width: AppWidthManager.w3Point8,
                                ),
                                AppTextWidget(
                                  text: "No Smoking",
                                  color: AppColorManager.white,
                                  fontSize: FontSizeManager.fs16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppHeightManager.h1,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    height: AppHeightManager.h3,
                                    width: AppHeightManager.h3,
                                    child: SvgPicture.asset(
                                      AppIconManager.noSmoke,
                                      color: AppColorManager.white,
                                    )),
                                SizedBox(
                                  width: AppWidthManager.w3Point8,
                                ),
                                AppTextWidget(
                                  text: "No Smoking",
                                  color: AppColorManager.white,
                                  fontSize: FontSizeManager.fs16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppHeightManager.h4,
                        ),
                        TripDetailsBottomSheet(
                          tripCode: "2",
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
