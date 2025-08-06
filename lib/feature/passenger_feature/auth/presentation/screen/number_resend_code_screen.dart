import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:servi_drive/feature/passenger_feature/auth/domain/entity/request/resend_otp_request_entity.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/resend_otp_cubit/resend_otp_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/cubit/resend_otp_cubit/resend_otp_state.dart';
import 'package:servi_drive/feature/passenger_feature/auth/presentation/screen/verification_code_screen.dart';

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

import '../../../../../main.dart';
import '../../../../../router/router.dart';

class NumberResendCodeScreen extends StatefulWidget {
  const NumberResendCodeScreen({super.key});

  @override
  State<NumberResendCodeScreen> createState() => _NumberResendCodeScreenState();
}

class _NumberResendCodeScreenState extends State<NumberResendCodeScreen> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    overlayColor: const WidgetStatePropertyAll(
                        AppColorManager.transparent),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                        LanguageHelper.checkIfLTR(context: context)
                            ? AppIconManager.arrowLeft
                            : AppIconManager.arrowRight,
                        colorFilter: const ColorFilter.mode(
                            AppColorManager.black, BlendMode.srcIn)),
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightManager.h15,
              ),
              AppTextWidget(
                text: "verifyAccount".tr(),
                fontSize: FontSizeManager.fs24,
                fontWeight: FontWeight.w700,
                color: AppColorManager.darkMainColor,
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              AppTextWidget(
                text: "enterThePhoneNumberThatYouUsedToCreateAccount".tr(),
                maxLines: 10,
                fontSize: FontSizeManager.fs16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                color: AppColorManager.grey,
              ),
              SizedBox(
                height: AppHeightManager.h1,
              ),
              SizedBox(
                height: AppHeightManager.h6,
              ),
              BlocConsumer<ResendOtpCubit, ResendOtpState>(
                listener: (context, state) {
                  if (state.status == CubitStatus.error) {
                    NoteMessage.showErrorSnackBar(
                        context: context, text: state.error);
                  }
                  if (state.status == CubitStatus.success) {
                    Navigator.of(context)
                        .pushNamed(RouteNamedScreens.verificationCode,
                            arguments: VerificationCodeArgs(
                              isResendOtp: true,
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

                            context.read<ResendOtpCubit>().resendOtp(
                                context: context,
                                entity: ResendOtpRequestEntity(
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
