import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/widget/button/circular_back_button.dart';
import 'package:servi_drive/core/widget/container/shimmer_container.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';

import 'dart:ui' as ui;

import '../../../../../core/helper/language_helper.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/icon_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
import '../../../../router/router.dart';
import '../../domain/entity/request/verify_otp_request_entity.dart';
import '../cubit/verfiy_otp_cubit/verfiy_otp_cubit.dart';
import '../cubit/verfiy_otp_cubit/verfiy_otp_state.dart';
import '../widget/resend_verification_widget.dart';
import '../widget/verification_digit_widget.dart';

class VerificationCodeScreen extends StatefulWidget {
  final VerificationCodeArgs args;

  const VerificationCodeScreen({super.key, required this.args});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                text: "enterCode".tr(),
                fontSize: FontSizeManager.fs18,
                fontWeight: FontWeight.w700,
                color: AppColorManager.darkMainColor,
              ),
              SizedBox(
                height: AppHeightManager.h1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w4),
                child: RichText(
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "otpSentMessage".tr(),
                    style: TextStyle(
                      fontFamily: FontFamilyManager.cairo,
                      fontSize: FontSizeManager.fs15,
                      color: AppColorManager.grey,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.args.phoneNumber,
                          style: TextStyle(
                              fontFamily: FontFamilyManager.cairo,
                              fontSize: FontSizeManager.fs15,
                              color: AppColorManager.mainColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppHeightManager.h6,
              ),
              BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
                listener: (context, state) {
                  if (state.status == CubitStatus.error) {
                    NoteMessage.showErrorSnackBar(
                        context: context, text: state.error);
                  }
                  if (state.status == CubitStatus.success) {
                    if (widget.args.isResendOtp == true) {
                      NoteMessage.showSuccessSnackBar(
                          context: context,
                          text: "accountVerifiedSuccessfully".tr());
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      return;
                    }
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteNamedScreens.main,
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status == CubitStatus.loading) {
                    return ShimmerContainer(
                        width: AppWidthManager.w100,
                        height: AppHeightManager.h6point6);
                  }
                  return Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: VerificationCodeWidget(onCodeEntered: (value) {
                        context.read<VerifyOtpCubit>().verifyOtp(
                            context: context,
                            entity: VerifyOtpRequestEntity(
                                otpCode: value,
                                phoneNumber: widget.args.phoneNumber));
                      }));
                },
              ),
              SizedBox(
                height: AppHeightManager.h5,
              ),
              SizedBox(
                height: AppHeightManager.h2,
              ),
              ResendVerificationWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class VerificationCodeArgs {
  final String phoneNumber;
  final bool isResendOtp;

  VerificationCodeArgs({required this.phoneNumber, required this.isResendOtp});
}
