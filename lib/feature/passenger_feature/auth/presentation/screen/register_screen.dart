import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:servi_drive/core/helper/app_image_helper.dart';
import 'package:servi_drive/core/helper/file_helper.dart';
import 'package:servi_drive/core/resource/color_manager.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/bottom_sheet/main_app_bottom_sheet.dart';
import 'package:servi_drive/core/widget/container/dot_container.dart';
import 'package:servi_drive/core/widget/container/shimmer_container.dart';
import 'package:servi_drive/core/widget/drop_down/NameAndId.dart';
import 'package:servi_drive/core/widget/drop_down/title_drop_down_form_field.dart';
import 'package:servi_drive/core/widget/form_field/title_app_form_filed.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/request/register_request_entity.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/screen/verification_code_screen.dart';
import 'package:servi_drive/router/router.dart';

import '../../../../../core/resource/constant_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/form_field/title_calendar_form_field.dart';
import '../../../../../core/widget/form_field/title_time_form_field.dart';
import 'dart:ui' as ui;

import '../../../trip/presentation/cubit/new_trip_cubit/new_trip_cubit.dart';
import '../cubit/register_cubit/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterRequestEntity registerRequestEntity = RegisterRequestEntity();
  bool showUserNameNote = false;
  bool showPasswordNote = false;
  File? profileImage;
  List<NameAndId> genders = [
    NameAndId(name: "male".tr(), id: "Male"),
    NameAndId(name: "female".tr(), id: "Female"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == CubitStatus.error) {
            NoteMessage.showErrorSnackBar(context: context, text: state.error);
          }
          if (state.status == CubitStatus.success) {
            Navigator.of(context).pushNamed(RouteNamedScreens.verificationCode,
                arguments: VerificationCodeArgs(
                    isResendOtp: false,
                    phoneNumber: registerRequestEntity.phoneNumber ?? ""));
          }
        },
        builder: (context, state) {
          if (state.status == CubitStatus.loading) {
            return Padding(
              padding: EdgeInsets.all(AppWidthManager.w3Point8),
              child: ShimmerContainer(
                  width: AppWidthManager.w100,
                  height: AppHeightManager.h6point6),
            );
          }
          return MainAppBottomSheet(
            title: "registerNow".tr(),
            onTap: () {
              print(registerRequestEntity.fullName);
              print(registerRequestEntity.username);
              print(registerRequestEntity.phoneNumber);
              print(registerRequestEntity.password);
              if ((registerRequestEntity.fullName ?? "").isEmpty ||
                  (registerRequestEntity.username ?? '').isEmpty ||
                  (registerRequestEntity.phoneNumber ?? '').isEmpty ||
                  (registerRequestEntity.password ?? '').isEmpty) {
                NoteMessage.showErrorSnackBar(
                    context: context, text: "enterAllRequiredField".tr());
                return;
              }
              context
                  .read<RegisterCubit>()
                  .register(context: context, entity: registerRequestEntity);
            },
          );
        },
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
                    registerRequestEntity.username = value?.trim();
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
                          String? newPhone = value.phoneNumber;
                          if (value.phoneNumber?.startsWith("0") ?? false) {
                            newPhone = value.phoneNumber?.replaceFirst("0", "");
                            print(newPhone);
                          }

                          registerRequestEntity.phoneNumber = newPhone;
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
                    registerRequestEntity.password = value;

                    return null;
                  },
                  validator: (value) {
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
                                      text: 'minPasswordLengthIs6'.tr(),
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
                        onDateChanged: (p0) {
                          registerRequestEntity.dateOfBirth =
                              p0.toUtc().toString();
                        },
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
                  height: AppHeightManager.h2,
                ),
                MainAppButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
                  borderRadius: BorderRadius.circular(AppRadiusManager.r15),
                  height: AppHeightManager.h6,
                  onTap: () async {
                    profileImage = await AppImageHelper.pickImageFrom(
                        source: ImageSource.gallery);

                    if (profileImage?.path != null) {
                      registerRequestEntity.image =
                          FileHelper.convertToBase64WithHeader(
                              file: profileImage);


                    }
                    setState(() {

                    });
                  },
                  outLinedBorde: true,
                  borderColor: profileImage?.path != null
                      ? AppColorManager.red
                      : AppColorManager.mainColor,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: profileImage!=null,
                        child: InkWell(
                          onTap: () {
                            profileImage = null;
                            setState(() {});
                          },
                          child: CircleAvatar(
                              backgroundColor: AppColorManager.red,
                              radius: AppWidthManager.w4,
                              child: Icon(
                                Icons.close,
                                size: AppWidthManager.w4,
                                color: AppColorManager.white,
                              )),
                        ),
                      ),
                      Visibility(
                        visible: profileImage!=null,

                        child: SizedBox(
                          width: AppWidthManager.w1Point5,
                        ),
                      ),
                      AppTextWidget(
                        text: "profileImage".tr(),
                        fontSize: FontSizeManager.fs16,
                        color: profileImage?.path != null
                            ? AppColorManager.red
                            : AppColorManager.mainColor,
                      ),
                    ],
                  ),
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
