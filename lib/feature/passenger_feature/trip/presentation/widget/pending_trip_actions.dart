import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:servi_drive/router/router.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

class PendingTripActions extends StatelessWidget {
  const PendingTripActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MainAppButton(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
            borderRadius: BorderRadius.circular(AppRadiusManager.r15),
            height: AppHeightManager.h6point6,
            onTap: () {
              Navigator.of(context).pushNamed(RouteNamedScreens.tripOffers);
            },
            color: AppColorManager.lightMainColor,
            borderColor: AppColorManager.mainColor,
            alignment: Alignment.center,
            child: AppTextWidget(
              text: "Check Offers".tr(),
              fontSize: FontSizeManager.fs16,
              color: AppColorManager.white,
            ),
          ),
        ),
        SizedBox(
          width: AppWidthManager.w3Point8,
        ),
        Expanded(
          child: MainAppButton(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
            borderRadius: BorderRadius.circular(AppRadiusManager.r15),
            height: AppHeightManager.h6point6,
            onTap: () {},
            outLinedBorde: true,
            color: AppColorManager.darkMainColor,
            borderColor: AppColorManager.mainColor,
            alignment: Alignment.center,
            child: AppTextWidget(
              text: "Close Trip".tr(),
              fontSize: FontSizeManager.fs16,
              color: AppColorManager.mainColor,
            ),
          ),
        ),
      ],
    );
  }
}
