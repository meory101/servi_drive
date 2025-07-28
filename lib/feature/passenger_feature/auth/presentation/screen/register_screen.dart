import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:servi_drive/core/resource/color_manager.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/bottom_sheet/main_app_bottom_sheet.dart';
import 'package:servi_drive/core/widget/container/dot_container.dart';
import 'package:servi_drive/core/widget/drop_down/NameAndId.dart';
import 'package:servi_drive/core/widget/drop_down/title_drop_down_form_field.dart';
import 'package:servi_drive/core/widget/form_field/title_app_form_filed.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/request/register_request_entity.dart';

import '../../../../../core/resource/constant_manager.dart';
import '../../../../../core/widget/form_field/title_calendar_form_field.dart';
import '../../../../../core/widget/form_field/title_time_form_field.dart';
import 'dart:ui' as ui;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterRequestEntity registerRequestEntity = RegisterRequestEntity();
  bool showUserNameNote = false;
  bool showPasswordNote = false;
  List<NameAndId> genders = [
    NameAndId(name: "male".tr(), id: "Male"),
    NameAndId(name: "female".tr(), id: "Female"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: MainAppBottomSheet(
        title: "registerNow".tr(),
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
                  text: 'Register'.tr(),
                  fontSize: FontSizeManager.fs20,
                  color: AppColorManager.darkMainColor,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: AppHeightManager.h02,
                ),
                AppTextWidget(
                  text: 'pleaseFillTheFollowingFieldToCreateAnAccount'.tr(),
                  fontSize: FontSizeManager.fs15,
                  color: AppColorManager.grey,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: AppHeightManager.h4,
                ),
                TitleAppFormFiled(
                  isRequired: true,
                  hint: "fullName".tr(),
                  title: "fullName".tr(),
                  onChanged: (value) {
                    registerRequestEntity.fullName = value;
                    return null;
                  },
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                TitleAppFormFiled(
                  isRequired: true,
                  hint: "username".tr(),
                  title: "username".tr(),
                  onChanged: (value) {
                    registerRequestEntity.username = value;
                    return null;
                  },
                  validator: (value) {
                    return null;
                  },
                  tileActionWidget: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showUserNameNote = !showUserNameNote;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.info_outlined,
                        color: AppColorManager.grey,
                        size: AppWidthManager.w5point5,
                      )),
                ),
                AnimatedSwitcher(
                    duration: 400.ms,
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: showUserNameNote
                        ? Column(
                            key: ValueKey(true), // Needed for AnimatedSwitcher
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppHeightManager.h1point8),
                              Row(
                                children: [
                                  DotContainer(
                                      color: AppColorManager.mainColor),
                                  SizedBox(width: AppWidthManager.w2point5),
                                  AppTextWidget(
                                    text: 'userNameHasToBeUnique'.tr(),
                                    fontSize: FontSizeManager.fs15,
                                    color: AppColorManager.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  DotContainer(
                                      color: AppColorManager.mainColor),
                                  SizedBox(width: AppWidthManager.w2point5),
                                  Expanded(
                                    child: AppTextWidget(
                                      text:
                                          'thisIsWhatYouWillUseToLoginInPleaseRememberIt'
                                              .tr(),
                                      fontSize: FontSizeManager.fs15,
                                      color: AppColorManager.grey,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppHeightManager.h1point8),
                            ],
                          )
                            .animate(
                              delay: 100.ms,
                            )
                            .fadeIn(duration: 400.ms)
                            .slideX(
                                begin: 0.3,
                                end: 0,
                                duration: 400.ms,
                                curve: Curves.easeOut)
                            .scale(duration: 400.ms)
                        : Center()),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: "phoneNumber".tr(),
                      fontSize: FontSizeManager.fs16,
                      fontWeight: FontWeight.w600,
                      color: AppColorManager.darkMainColor,
                    ),
                    SizedBox(height: AppHeightManager.h08),
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber value) {
                          registerRequestEntity.phoneNumber = value.phoneNumber;
                        },
                        inputBorder: InputBorder.none,
                        hintText: "phoneNumber".tr(),
                        keyboardType: TextInputType.phone,
                        countrySelectorScrollControlled: true,
                        validator: (p0) {
                          return null;
                        },
                        textStyle: TextStyle(
                            height: 2.2,
                            fontFamily: FontFamilyManager.cairo,
                            color: AppColorManager.textAppColor,
                            fontSize: FontSizeManager.fs17),
                        textAlign: TextAlign.left,
                        initialValue:
                            PhoneNumber(isoCode: AppConstantManager.isoCode),
                        keyboardAction: TextInputAction.done,
                        cursorColor: AppColorManager.lightMainColor,
                        selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            leadingPadding: AppWidthManager.w5,
                            trailingSpace: false,
                            showFlags: true,
                            useBottomSheetSafeArea: true,
                            setSelectorButtonAsPrefixIcon: true),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                TitleAppFormFiled(
                  isRequired: true,
                  hint: "password".tr(),
                  title: "password".tr(),
                  onChanged: (value) {
                    return null;
                  },
                  validator: (value) {
                    registerRequestEntity.password = value;
                    return null;
                  },
                  tileActionWidget: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showPasswordNote = !showPasswordNote;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.info_outlined,
                        color: AppColorManager.grey,
                        size: AppWidthManager.w5point5,
                      )),
                ),
                AnimatedSwitcher(
                    duration: 400.ms,
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: showPasswordNote
                        ? Column(
                      key: ValueKey(true), // Needed for AnimatedSwitcher
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppHeightManager.h1point8),
                        Row(
                          children: [
                            DotContainer(
                                color: AppColorManager.mainColor),
                            SizedBox(width: AppWidthManager.w2point5),
                            Expanded(
                              child: AppTextWidget(
                                text:
                                'minPasswordLengthIs6'
                                    .tr(),
                                fontSize: FontSizeManager.fs15,
                                color: AppColorManager.grey,
                                fontWeight: FontWeight.w500,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppHeightManager.h1point8),
                      ],
                    )
                        .animate(
                      delay: 100.ms,
                    )
                        .fadeIn(duration: 400.ms)
                        .slideX(
                        begin: 0.3,
                        end: 0,
                        duration: 400.ms,
                        curve: Curves.easeOut)
                        .scale(duration: 400.ms)
                        : Center()),
                SizedBox(
                  height: AppHeightManager.h4,
                ),
                Divider(
                  color: AppColorManager.lightGreyOpacity6,
                ),
                SizedBox(
                  height: AppHeightManager.h4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TitleCalendarFormField(
                        minDate: DateTime(DateTime.now().year - 18),
                        title: "dateOfBirth".tr(),
                        onDateChanged: (p0) {},
                        hint: "Date".tr(),
                      ),
                    ),
                    SizedBox(
                      width: AppWidthManager.w2,
                    ),
                    Expanded(
                      child: TitleDropDownFormFieldWidget(
                        title: "gender".tr(),
                        hint: "gender".tr(),
                        options: genders,
                        onChanged: (value) {
                          registerRequestEntity.gender = value?.id;
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                TitleAppFormFiled(
                  hint: "email".tr(),
                  title: "email".tr(),
                  onChanged: (value) {
                    registerRequestEntity.email = value;

                    return null;
                  },
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(
                  height: AppHeightManager.h10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
