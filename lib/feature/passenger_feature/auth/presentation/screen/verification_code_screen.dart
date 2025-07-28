import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:ui' as ui;

import '../../../../../core/helper/language_helper.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/icon_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
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
                text: "enterCode".tr(),
                fontSize: FontSizeManager.fs24,
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
              Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: VerificationCodeWidget(onCodeEntered: (value) {})),
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

  VerificationCodeArgs({required this.phoneNumber});
}
