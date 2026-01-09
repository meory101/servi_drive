import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:servi_drive/feature/auth/presentation/screen/reset_password_screen.dart';

import '../../../../../core/helper/language_helper.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/constant_manager.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/icon_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/container/shimmer_container.dart';
import '../../../../../core/widget/snack_bar/note_message.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
import 'dart:ui' as ui;
import '../../../../../router/router.dart';
import '../../../../core/widget/button/circular_back_button.dart';
import '../../domain/entity/request/forgot_password_request_entity.dart';
import '../cubit/forgot_password_cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_cubit/forgot_password_state.dart';

class NumberResetPasswordScreen extends StatefulWidget {
  const NumberResetPasswordScreen({super.key});

  @override
  State<NumberResetPasswordScreen> createState() => _NumberResetPasswordScreenState();
}

class _NumberResetPasswordScreenState extends State<NumberResetPasswordScreen> {
  String? newPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w4),
          child: Column(
            children: [
              SizedBox(
                height: AppHeightManager.h10,
              ),
              CircularBackButton(),

              SizedBox(
                height: AppHeightManager.h15,
              ),
              AppTextWidget(
                text: "forgotPassword".tr(),
                fontSize: FontSizeManager.fs18,
                fontWeight: FontWeight.w700,
                color: AppColorManager.darkMainColor,
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              AppTextWidget(
                text: "enterPhoneToResetPassword".tr(),
                maxLines: 10,
                fontSize: FontSizeManager.fs16,
                fontWeight: FontWeight.w500,
                color: AppColorManager.grey,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: AppHeightManager.h1,
              ),
              SizedBox(
                height: AppHeightManager.h6,
              ),
              BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                listener: (context, state) {
                  if (state.status == CubitStatus.error) {
                    NoteMessage.showErrorSnackBar(
                        context: context, text: state.error);
                  }
                  if (state.status == CubitStatus.success) {
                    Navigator.of(context)
                        .pushNamed(RouteNamedScreens.resetPassword,
                        arguments: ResetPasswordArgs(
                          phoneNumber: newPhone??"",
                        ));
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber value) {
                            newPhone = value.phoneNumber;
                            if (value.phoneNumber?.startsWith("0") ?? false) {
                              newPhone =
                                  value.phoneNumber?.replaceFirst("0", "");
                            }
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
                      SizedBox(
                        height: AppHeightManager.h1point8,
                      ),
                      Visibility(
                        visible: state.status == CubitStatus.loading,
                        replacement: MainAppButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppWidthManager.w10),
                          borderRadius:
                          BorderRadius.circular(AppRadiusManager.r15),
                          height: AppHeightManager.h6point6,
                          onTap: () {
                            if ((newPhone ?? "").isEmpty) {
                              return;
                            }

                            context.read<ForgotPasswordCubit>().forgotPassword(
                                context: context,
                                entity: ForgotPasswordRequestEntity(
                                    phoneNumber: newPhone));
                          },
                          gradientColors: [
                            AppColorManager.mainColor,
                            AppColorManager.mainColor,
                          ],
                          alignment: Alignment.center,
                          child: AppTextWidget(
                            text: "sendCode".tr(),
                            fontSize: FontSizeManager.fs16,
                            color: AppColorManager.white,
                          ),
                        ),
                        child: ShimmerContainer(
                            width: AppWidthManager.w100,
                            height: AppHeightManager.h6point6),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: AppHeightManager.h5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



