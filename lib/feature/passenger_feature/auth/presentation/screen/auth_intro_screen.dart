import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servi_drive/core/resource/color_manager.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/button/main_app_button.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';
import 'package:servi_drive/router/router.dart';


class AuthIntroScreen extends StatefulWidget {
  const AuthIntroScreen({super.key});

  @override
  State<AuthIntroScreen> createState() => _AuthIntroScreenState();
}

class _AuthIntroScreenState extends State<AuthIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.darkMainColor,
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppHeightManager.h15,
            ),
            AppTextWidget(
              text: "Servi Drive",
              color: AppColorManager.white,
              fontSize: FontSizeManager.fs32,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: AppHeightManager.h12,
            ),
            AppTextWidget(
              text: "hello".tr(),
              color: AppColorManager.white,
              fontSize: FontSizeManager.fs18,
              fontWeight: FontWeight.w700,
            ),
            AppTextWidget(
              text: "welcomeToServiDrive".tr(),
              color: AppColorManager.white,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: AppHeightManager.h5,
            ),
            MainAppButton(
              alignment: Alignment.center,
              padding:
                  EdgeInsets.symmetric(horizontal: AppWidthManager.w1Point8),
              margin: EdgeInsets.symmetric(horizontal: AppWidthManager.w5),
              width: AppWidthManager.w100,
              height: AppHeightManager.h6,
              onTap: () {
                Navigator.of(context).pushNamed(RouteNamedScreens.register);
              },
              color: AppColorManager.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircleAvatar(
                  //     child: SvgPicture.asset(AppIconManager.arrowMenuLeft)),
                  // Spacer(),
                  AppTextWidget(
                    text: 'Create An Account'.tr(),
                    color: AppColorManager.darkMainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: FontSizeManager.fs17,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            MainAppButton(
              alignment: Alignment.center,
              padding:
                  EdgeInsets.symmetric(horizontal: AppWidthManager.w1Point8),
              margin: EdgeInsets.symmetric(horizontal: AppWidthManager.w5),
              width: AppWidthManager.w100,
              height: AppHeightManager.h6,
              onTap: () {
                Navigator.of(context).pushNamed(RouteNamedScreens.login);
              },
              color: AppColorManager.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircleAvatar(
                  //     child: SvgPicture.asset(AppIconManager.arrowMenuLeft)),
                  // Spacer(),
                  AppTextWidget(
                    text: 'Login'.tr(),
                    color: AppColorManager.darkMainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: FontSizeManager.fs17,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
