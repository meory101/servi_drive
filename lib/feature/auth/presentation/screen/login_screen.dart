import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/storage/shared/shared_pref.dart';
import 'package:servi_drive/core/widget/button/circular_back_button.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';
import 'package:servi_drive/router/router.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/bottom_sheet/main_app_bottom_sheet.dart';
import '../../../../../core/widget/container/shimmer_container.dart';
import '../../../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
import '../../domain/entity/request/login_request_entity.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginRequestEntity loginRequestEntity = LoginRequestEntity();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        bottomSheet: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == CubitStatus.error) {
              NoteMessage.showErrorSnackBar(context: context, text: state.error);
            }
            if (state.status == CubitStatus.success) {
              print(state.entity.isVerified);
              if ((state.entity.isVerified ?? true) == false) {
                Navigator.of(context).pushNamed(
                    RouteNamedScreens.numberResendCodeScreen,);
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNamedScreens.main,
                  (route) => false,
                );
              }
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
              title: "login".tr(),
              onTap: () {
                if ((loginRequestEntity.password ?? "").isEmpty ||
                    (loginRequestEntity.username ?? '').isEmpty) {
                  NoteMessage.showErrorSnackBar(
                      context: context, text: "enterAllRequiredField".tr());
                  return;
                }
                AppSharedPreferences.clear();
                context
                    .read<LoginCubit>()
                    .login(context: context, entity: loginRequestEntity);
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
                    text: 'Login'.tr(),
                    fontSize: FontSizeManager.fs20,
                    color: AppColorManager.darkMainColor,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: AppHeightManager.h02,
                  ),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppTextWidget(text: "dontHaveAnAccount".tr(),

                          fontSize: FontSizeManager.fs15,
                          color: AppColorManager.grey,
                          fontWeight: FontWeight.w500
                          ,),
                      SizedBox(width: AppWidthManager.w1,),
                      AppTextWidget(text: "register".tr(),color: AppColorManager.mainColor
                          ,fontSize: FontSizeManager.fs16

                          ,onTap:() {
                        Navigator.of(context).pushNamed(RouteNamedScreens.register);
                      },),
                    ],
                  )
                  ,

                  SizedBox(
                    height: AppHeightManager.h4,
                  ),
                  TitleAppFormFiled(
                    isRequired: true,
                    hint: "username".tr(),
                    title: "username".tr(),
                    onChanged: (value) {
                      loginRequestEntity.username = value?.trim();
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
                      loginRequestEntity.password = value;

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
                        onTap: () {
                          Navigator.of(context).pushNamed(RouteNamedScreens.numberResetPasswordScreen);
                        },
                        text: "forgotPassword".tr(),
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
      ),
    );
  }
}
