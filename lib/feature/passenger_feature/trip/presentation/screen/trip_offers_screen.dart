import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class TripOffersScreen extends StatefulWidget {
  const TripOffersScreen({super.key});

  @override
  State<TripOffersScreen> createState() => _TripOffersScreenState();
}

class _TripOffersScreenState extends State<TripOffersScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Trip Offers"),
      body: SingleChildScrollView(
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return DecoratedContainer(
                        margin:
                            EdgeInsets.only(bottom: AppHeightManager.h1point8),
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
                                imagePath: AppImageManager.placeholder,
                              ),
                            ),
                            SizedBox(width: AppWidthManager.w1Point8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: "Driver Name",
                                        color: AppColorManager.darkMainColor,
                                        fontSize: FontSizeManager.fs16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppTextWidget(
                                        text: "200\$",
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
                                          text:
                                              "Offer Offer Offer  Offer Offer Offer OOffer Offer Offer OOffer Offer Offer Offer Offer Offer Offer",
                                          color: AppColorManager.textGrey,
                                          fontSize: FontSizeManager.fs15,
                                          fontWeight: FontWeight.w500,
                                          maxLines: 100,
                                        ),
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
    );
  }
}
