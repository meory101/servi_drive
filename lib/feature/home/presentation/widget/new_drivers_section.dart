import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/helper/language_helper.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/image_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/image/main_image_widget.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

class NewDriversSection extends StatelessWidget {
  const NewDriversSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
          child: AppTextWidget(text: 'New Joined Drivers'.tr()
            ,
            fontWeight: FontWeight.w700,
            fontSize: FontSizeManager.fs17,
          ),
        ),
        SizedBox(height: AppHeightManager.h1point8,),
        SizedBox(
          height: AppHeightManager.h15,
          child: ListView.builder(
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: 9,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: index==0? AppWidthManager.w3Point8:! LanguageHelper.checkIfLTR(context: context) ?
                    AppWidthManager.w3Point8:0,
                    right: index==0? AppWidthManager.w3Point8: LanguageHelper.checkIfLTR(context: context) ?
                    AppWidthManager.w3Point8:0
                ),
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: AppWidthManager.w15,
                      width: AppWidthManager.w15,
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
              );
            },
          ),
        )
      ],
    );
  }
}
