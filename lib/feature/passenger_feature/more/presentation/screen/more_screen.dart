import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servi_drive/core/resource/color_manager.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/resource/icon_manager.dart';
import 'package:servi_drive/core/resource/image_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/image/main_image_widget.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';
import 'package:servi_drive/router/router.dart';

import '../widget/basics_item.dart';
import '../widget/settings_item.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        height: AppHeightManager.h20,
        decoration: BoxDecoration(color: AppColorManager.darkMainColor),
      ),
      Container(
        margin: EdgeInsets.only(top: AppHeightManager.h10),
        decoration: BoxDecoration(
            color: AppColorManager.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppRadiusManager.r20),
              topRight: Radius.circular(AppRadiusManager.r20),
            )),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: AppHeightManager.h5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: AppWidthManager.w25,
                  width: AppWidthManager.w25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColorManager.white,
                  ),
                  child: MainImageWidget(
                    imagePath: AppImageManager.placeholder,
                  ),
                ),
                AppTextWidget(
                  text: "Nour Othman",
                  color: AppColorManager.darkMainColor,
                  fontSize: FontSizeManager.fs17,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: AppHeightManager.h24),
        padding: EdgeInsets.all(AppWidthManager.w3Point8),
        child: Column(
          children: [
            BasicsItem(title: "Edit Profile".tr(), onTap: () {}),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            BasicsItem(title: "My Trips".tr(), onTap: () {
              Navigator.of(context).pushNamed(RouteNamedScreens.myTrips);
            }),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            BasicsItem(title: "Privacy Policy".tr(), onTap: () {}),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            BasicsItem(title: "About Us".tr(), onTap: () {}),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                        height: AppHeightManager.h8,
                        child: SettingsItem(
                            title: "Language".tr(), onTap: () {}))),
                SizedBox(width: AppWidthManager.w2,),
                Expanded(
                    child: SizedBox(
                        height: AppHeightManager.h8,
                        child: SettingsItem(
                            title: "Contact Us".tr(), onTap: () {}))),
              ],
            ),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                        height: AppHeightManager.h8,
                        child: SettingsItem(
                            title: "Logout".tr(), onTap: () {}))),
                SizedBox(width: AppWidthManager.w2,),
                Expanded(
                    child: SizedBox(
                        height: AppHeightManager.h8,
                        child: SettingsItem(
                            title: "Delete Account".tr(), onTap: () {}))),
              ],
            ),

          ],
        ),
      )
    ]));
  }
}
