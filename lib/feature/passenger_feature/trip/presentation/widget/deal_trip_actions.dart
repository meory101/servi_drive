import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servi_drive/router/router.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/image_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/container/decorated_container.dart';
import '../../../../../core/widget/image/main_image_widget.dart';
import '../../../../../core/widget/text/app_text_widget.dart';


class DealTripActions extends StatelessWidget {
  const DealTripActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedContainer(
          padding: EdgeInsets.all(AppWidthManager.w3Point8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNamedScreens.driverInfo);
                },
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: AppWidthManager.w14,
                      width: AppWidthManager.w14,
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
                children: [
                  CircleAvatar(
                    radius: AppRadiusManager.r20,
                    child: Icon(
                      Icons.call,
                      color: AppColorManager.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: AppHeightManager.h2,
        ),
        MainAppButton(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
          borderRadius: BorderRadius.circular(AppRadiusManager.r15),
          height: AppHeightManager.h6point6,
          onTap: () {},
          outLinedBorde: true,
          color: AppColorManager.darkMainColor,
          borderColor: AppColorManager.red,
          alignment: Alignment.center,
          child: AppTextWidget(
            text: "Cancel Trip".tr(),
            fontSize: FontSizeManager.fs16,
            color: AppColorManager.red,
          ),
        )
      ],
    );
  }
}
