import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/bottom_sheet/main_app_bottom_sheet.dart';
import '../../../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: MainAppBottomSheet(
        title: "login".tr(),
        onTap: () {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppWidthManager.w3Point8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppHeightManager.h4,
                ),
                AppTextWidget(
                  text: 'Login'.tr(),
                  fontSize: FontSizeManager.fs20,
                  color: AppColorManager.darkMainColor,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: AppHeightManager.h02,
                ),
                AppTextWidget(
                  text: 'loginToContinueToYourAccount'.tr(),
                  fontSize: FontSizeManager.fs15,
                  color: AppColorManager.grey,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: AppHeightManager.h4,
                ),
                TitleAppFormFiled(
                  isRequired: true,
                  hint: "username".tr(),
                  title: "username".tr(),
                  onChanged: (value) {
                    return null;
                  },
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(
                  height: AppHeightManager.h2,
                ),
                TitleAppFormFiled(
                  isRequired: true,
                  hint: "password".tr(),
                  title: "password".tr(),
                  onChanged: (value) {
                    return null;
                  },
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(
                  height: AppHeightManager.h08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppTextWidget(
                      text: "forgotPassword?".tr(),
                      color: AppColorManager.lightMainColor,
                    )
                  ],
                ),
                SizedBox(
                  height: AppHeightManager.h4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
