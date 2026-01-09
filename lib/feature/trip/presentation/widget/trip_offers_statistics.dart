import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/container/decorated_container.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';

import '../../../../../core/resource/color_manager.dart';

class TripOffersStatistics extends StatelessWidget {
  const TripOffersStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DecoratedContainer(
                alignment: Alignment.center,
                height: AppHeightManager.h16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColorManager.blue,
                      child: Icon(CupertinoIcons.money_dollar
                      ),
                    ),
                    SizedBox(height: AppHeightManager.h06,),
                    AppTextWidget(text: "Min Offer Price",
                    fontSize: FontSizeManager.fs16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: AppWidthManager.w3Point8,),
            Expanded(
              child: DecoratedContainer(
                alignment: Alignment.center,
                height: AppHeightManager.h16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColorManager.orange,
                      child: Icon(Icons.price_check_outlined
                      ),
                    ),
                    SizedBox(height: AppHeightManager.h06,),
                    AppTextWidget(text: "Max Offer Price",
                      fontSize: FontSizeManager.fs16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),

        SizedBox(height: AppHeightManager.h1point8,),
        Row(
          children: [
            Expanded(
              child: DecoratedContainer(
                alignment: Alignment.center,
                height: AppHeightManager.h16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColorManager.green,
                      child: Icon(CupertinoIcons.arrow_right_arrow_left
                      ),
                    ),
                    SizedBox(height: AppHeightManager.h06,),
                    AppTextWidget(text: "Average Price",
                      fontSize: FontSizeManager.fs16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: AppWidthManager.w3Point8,),
            Expanded(
              child: DecoratedContainer(
                alignment: Alignment.center,
                height: AppHeightManager.h16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepPurpleAccent,
                      child: Icon(Icons.data_exploration_sharp,


                      ),
                    ),
                    SizedBox(height: AppHeightManager.h06,),
                    AppTextWidget(text: "Total Offers",
                      fontSize: FontSizeManager.fs16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}
