import 'package:flutter/cupertino.dart';

import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/image_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/image/main_image_widget.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return    Container(
      padding: EdgeInsets.only(
          top: AppHeightManager.h8,
          bottom: AppHeightManager.h1point8,
          left: AppWidthManager.w3Point8,

          right: AppWidthManager.w3Point8),
      height: AppHeightManager.h17,
      decoration: BoxDecoration(
          color: AppColorManager.darkMainColor,
          borderRadius: BorderRadius.circular(AppRadiusManager.r20)
      ),
      child: Row(
        children: [
          Container(

            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: AppWidthManager.w13,
            width: AppWidthManager.w13,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorManager.dotGrey,
            ),
            child: MainImageWidget(
              imagePath: AppImageManager.placeholder,
            ),
          ),
          SizedBox(
            width: AppWidthManager.w2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppHeightManager.h1,),
              AppTextWidget(
                text: "Hello Nour Othman!",
                color: AppColorManager.white,
                fontSize: FontSizeManager.fs18,
                fontWeight: FontWeight.w700,
              ),
              AppTextWidget(
                text: "Do you have a trip soon?",
                fontSize: FontSizeManager.fs15,
                fontWeight: FontWeight.w500,
                color: AppColorManager.textGrey,
              ),
            ],
          )
        ],
      ),
    );
  }
}
