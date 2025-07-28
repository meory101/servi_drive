import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servi_drive/core/widget/button/slide_button.dart';
import 'package:servi_drive/router/router.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/icon_manager.dart';
import '../../../../../core/resource/image_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/container/decorated_container.dart';
import '../../../../../core/widget/image/main_image_widget.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
import '../../../../../core/widget/text/status_text.dart';

class MyTripCard extends StatelessWidget {
  final int index;
  final bool? isActiveTrip;

  const MyTripCard({super.key, required this.index, this.isActiveTrip});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteNamedScreens.tripDetails);
      },
      child: DecoratedContainer(
        margin: EdgeInsets.only(bottom: AppHeightManager.h1point8),
        padding: EdgeInsets.all(AppWidthManager.w3Point8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteNamedScreens.driverInfo);
              },
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: AppWidthManager.w12,
                    width: AppWidthManager.w12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColorManager.darkMainColor,
                    ),
                    child: MainImageWidget(
                      imagePath: AppImageManager.placeholder,
                    ),
                  ),
                  SizedBox(width: AppWidthManager.w1Point8),
                  AppTextWidget(
                    text: "Driver Name",
                    color: AppColorManager.darkMainColor,
                    fontSize: FontSizeManager.fs16,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(
                  text: "Damascus-Amman",
                  fontWeight: FontWeight.w700,
                  fontSize: FontSizeManager.fs17,
                ),
                StatusText(
                    color: index == 0
                        ? AppColorManager.red
                        : index == 1
                            ? AppColorManager.orange
                            : index == 2
                                ? AppColorManager.blue
                                : AppColorManager.lightMainColor,
                    text: "status")
              ],
            ),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SvgPicture.asset(AppIconManager.calendar),
                AppTextWidget(
                  text: "3 Travellers",
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeManager.fs17,
                  color: AppColorManager.darkMainColor,
                ),
                SizedBox(
                    height: AppHeightManager.h2point5,
                    width: AppHeightManager.h2point5,
                    child: SvgPicture.asset(AppIconManager.person)),

                SizedBox(
                  width: AppWidthManager.w3Point8,
                ),

                AppTextWidget(
                  text: "Trip price",
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeManager.fs17,
                  color: AppColorManager.darkMainColor,
                ),
                SizedBox(
                  width: AppWidthManager.w1,
                ),

                AppTextWidget(
                  text: "240\$",
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeManager.fs17,
                  color: AppColorManager.lightMainColor,
                ),
              ],
            ),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            Visibility(
              visible: isActiveTrip == true,
              replacement: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: "From Location".tr(),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeManager.fs16,
                        color: AppColorManager.darkMainColor,
                      ),
                      AppTextWidget(
                        text: "33.33,34.55".tr(),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeManager.fs15,
                        color: AppColorManager.grey,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: "To Location".tr(),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeManager.fs16,
                        color: AppColorManager.darkMainColor,
                      ),
                      AppTextWidget(
                        text: "22.44,34.55",
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeManager.fs14,
                        color: AppColorManager.textGrey,
                      ),
                    ],
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: "Trip Date".tr(),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeManager.fs16,
                        color: AppColorManager.darkMainColor,
                      ),
                      AppTextWidget(
                        text: "Today".tr(),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeManager.fs15,
                        color: AppColorManager.grey,
                      ),
                    ],
                  ),
                  Container(
                    width: AppWidthManager.w45,
                    decoration: BoxDecoration(
                        border: Border(
                            top:
                                BorderSide(color: AppColorManager.borderGrey))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: "Time".tr(),
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeManager.fs16,
                        color: AppColorManager.darkMainColor,
                      ),
                      AppTextWidget(
                        text: "1:20 Am",
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeManager.fs14,
                        color: AppColorManager.textGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
