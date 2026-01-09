import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servi_drive/core/helper/app_image_helper.dart';
import 'package:servi_drive/core/helper/file_helper.dart';
import 'package:servi_drive/core/resource/color_manager.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/resource/icon_manager.dart';
import 'package:servi_drive/core/resource/image_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/container/shimmer_container.dart';
import 'package:servi_drive/core/widget/image/main_image_widget.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';
import 'package:servi_drive/router/router.dart';

import '../../../../../core/model/user.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../../../../core/widget/loading/app_circular_progress_widget.dart';
import '../../../../../core/widget/snack_bar/note_message.dart';
import '../../domain/entity/request/upload_profile_image_request_entity.dart';
import '../cubit/get_profile_cubit/get_profile_cubit.dart';
import '../cubit/get_profile_cubit/get_profile_state.dart';
import '../cubit/upload_profile_image_cubit/upload_profile_image_cubit.dart';
import '../cubit/upload_profile_image_cubit/upload_profile_image_state.dart';
import '../widget/basics_item.dart';
import '../widget/settings_item.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        context.read<GetProfileCubit>().getProfile(context: context);
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Stack(children: [
          Container(
            height: AppHeightManager.h20,
            decoration: BoxDecoration(color: AppColorManager.darkMainColor),
          ),
          Container(
            height: AppHeightManager.h80,
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
                    BlocConsumer<GetProfileCubit, GetProfileState>(
                      listener: (context, state) {
                        if (state.status == CubitStatus.error) {
                          NoteMessage.showErrorSnackBar(
                              context: context, text: state.error);
                        }
                      },
                      builder: (context, state) {
                        if (state.status == CubitStatus.loading) {
                          return Column(
                            children: [
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                height: AppWidthManager.w25,
                                width: AppWidthManager.w25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColorManager.white,
                                ),
                                child: ShimmerContainer(
                                  height: AppWidthManager.w25,
                                  width: AppWidthManager.w25,
                                  boxShape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                height: AppHeightManager.h1point8,
                              ),
                              ShimmerContainer(
                                  width: AppWidthManager.w30,
                                  height: AppHeightManager.h1point8)
                            ],
                          );
                        }

                        User? user = state.profile?.user;
                        return Column(
                          children: [
                            BlocConsumer<UploadProfileImageCubit,
                                UploadProfileImageState>(
                              listener: (context, state) {
                                if (state.status == CubitStatus.error) {
                                  NoteMessage.showErrorSnackBar(
                                      context: context, text: state.error);
                                }
                              },
                              builder: (context, state) {
                                if (state.status == CubitStatus.loading) {
                                  return Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    height: AppWidthManager.w25,
                                    width: AppWidthManager.w25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColorManager.white,
                                    ),
                                    child: ShimmerContainer(
                                      height: AppWidthManager.w25,
                                      width: AppWidthManager.w25,
                                      boxShape: BoxShape.circle,
                                    ),
                                  );
                                }
                                return InkWell(
                                  onTap: () async {
                                    profileImage =
                                        await AppImageHelper.pickImageFrom(
                                            source: ImageSource.gallery);

                                    if (profileImage?.path != null) {
                                      context
                                          .read<UploadProfileImageCubit>()
                                          .uploadProfileImage(
                                              context: context,
                                              entity: UploadProfileImageRequestEntity(
                                                  image: FileHelper
                                                      .convertToBase64WithHeader(
                                                          file:
                                                              profileImage!)));
                                    }

                                    setState(() {});
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        height: AppWidthManager.w25,
                                        width: AppWidthManager.w25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColorManager.white,
                                        ),
                                        child: (profileImage?.path ?? '')
                                                .isNotEmpty
                                            ? Image.file(
                                                profileImage!,
                                                fit: BoxFit.cover,
                                              )
                                            : MainImageWidget(
                                                imagePath:
                                                    AppImageManager.placeholder,
                                                imageUrl: user?.image ?? '',
                                                // imageUrl: user.,
                                              ),
                                      ),
                                      Positioned(
                                        top: AppHeightManager.h6point6,
                                        child: CircleAvatar(
                                          radius: AppWidthManager.w4,
                                          backgroundColor:
                                              AppColorManager.darkMainColor,
                                          child: Icon(
                                            Icons.edit,
                                            size: AppWidthManager.w4,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: AppHeightManager.h1point8,
                            ),
                            AppTextWidget(
                              text:
                                  user?.username ?? "",
                              color: AppColorManager.darkMainColor,
                              fontSize: FontSizeManager.fs17,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: AppHeightManager.h22),
            padding: EdgeInsets.all(AppWidthManager.w3Point8),
            child: Column(
              children: [
                BasicsItem(
                    title: "Edit Profile".tr(),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNamedScreens.editProfile);
                    }),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                BasicsItem(
                    title: "My Trips".tr(),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNamedScreens.myTrips);
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
                    SizedBox(
                      width: AppWidthManager.w2,
                    ),
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
                    SizedBox(
                      width: AppWidthManager.w2,
                    ),
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
        ]),
      ),
    ));
  }
}
