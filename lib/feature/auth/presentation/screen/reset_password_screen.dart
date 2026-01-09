import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../core/helper/language_helper.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/icon_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/container/shimmer_container.dart';
import '../../../../../core/widget/snack_bar/note_message.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
import 'dart:ui' as ui;

import '../../../../core/widget/button/circular_back_button.dart';
import '../../../../core/widget/form_field/title_app_form_filed.dart';
import '../../domain/entity/request/reset_password_request_entity.dart';
import '../cubit/reset_password_cubit/reset_password_cubit.dart';
import '../cubit/reset_password_cubit/reset_password_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  final ResetPasswordArgs args;

  const ResetPasswordScreen({super.key, required this.args});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetPasswordRequestEntity entity = ResetPasswordRequestEntity();

  @override
  void initState() {
    entity.phoneNumber = widget.args.phoneNumber;
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
                text: "resetPassword".tr(),
                fontSize: FontSizeManager.fs18,
                fontWeight: FontWeight.w700,
                color: AppColorManager.darkMainColor,
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              AppTextWidget(
                text: "resetPasswordSubtitle".tr(),
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
              BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                listener: (context, state) {
                  if (state.status == CubitStatus.error) {
                    NoteMessage.showErrorSnackBar(
                        context: context, text: state.error);
                  }
                  if (state.status == CubitStatus.success) {
                    NoteMessage.showSuccessSnackBar(
                        context: context,
                        text: "passwordResetSuccessfully".tr());
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      TitleAppFormFiled(
                        hint: "verificationCode".tr(),
                        title: "verificationCode".tr(),
                        textInputType: TextInputType.number,
                        onChanged: (value) {
                          entity.otpCode = value;
                          return null;
                        },
                        validator: (p0) => null,
                      ),
                      SizedBox(
                        height: AppHeightManager.h1point8,
                      ),
                      TitleAppFormFiled(
                        hint: "newPassword".tr(),
                        title: "newPassword".tr(),
                        textInputType: TextInputType.number,
                        onChanged: (value) {
                          entity.newPassword = value;
                          return null;
                        },
                        validator: (p0) => null,
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
                            if ((entity.newPassword ?? "").isEmpty ||
                                (entity.otpCode ?? "").isEmpty) {
                              return;
                            }
                            context.read<ResetPasswordCubit>().resetPassword(
                                context: context, entity: entity);
                          },
                          gradientColors: [
                            AppColorManager.mainColor,
                            AppColorManager.mainColor,
                          ],
                          alignment: Alignment.center,
                          child: AppTextWidget(
                            text: "resetNow".tr(),
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

class ResetPasswordArgs {
  String phoneNumber;

  ResetPasswordArgs({required this.phoneNumber});
}
