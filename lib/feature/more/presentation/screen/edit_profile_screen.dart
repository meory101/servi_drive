import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servi_drive/core/helper/app_image_helper.dart';
import 'package:servi_drive/core/helper/date_time_helper.dart';
import 'package:servi_drive/core/helper/file_helper.dart';
import 'package:servi_drive/core/resource/color_manager.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/app_bar/main_app_bar.dart';
import 'package:servi_drive/core/widget/bottom_sheet/main_app_bottom_sheet.dart';
import 'package:servi_drive/core/widget/container/shimmer_container.dart';
import 'package:servi_drive/core/widget/drop_down/NameAndId.dart';
import 'package:servi_drive/core/widget/drop_down/title_drop_down_form_field.dart';
import 'package:servi_drive/core/widget/form_field/title_app_form_filed.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';

import '../../../../../core/resource/constant_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/form_field/title_calendar_form_field.dart';
import '../../domain/entity/request/edit_profile_request_entity.dart';
import '../../domain/entity/response/profile_response_entity.dart';
import '../cubit/edit_profile_cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_cubit/edit_profile_state.dart';
import '../cubit/get_profile_cubit/get_profile_cubit.dart';
import '../cubit/get_profile_cubit/get_profile_state.dart';
import '../shimmer/edit_profile_shimmer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileRequestEntity editProfileRequestEntity =
      EditProfileRequestEntity();
  List<NameAndId> genders = [
    NameAndId(name: "male".tr(), id: "Male"),
    NameAndId(name: "female".tr(), id: "Female"),
  ];
  NameAndId? selectedGender;
  DateTime? selectedDateOfBirth;
  File? profileImage;

  @override
  void initState() {
    super.initState();
    // Load current profile data
    context.read<GetProfileCubit>().getProfile(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: MainAppBar(title: "editProfile".tr()),
        bottomSheet: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state.status == CubitStatus.error) {
              NoteMessage.showErrorSnackBar(context: context, text: state.error);
            }
            if (state.status == CubitStatus.success) {
              NoteMessage.showSuccessSnackBar(
                  context: context, text: 'profileUpdatedSuccessfully'.tr());
              Navigator.of(context).pop();
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
              title: "saveChanges".tr(),
              onTap: () {
                context.read<EditProfileCubit>().editProfile(
                    context: context, entity: editProfileRequestEntity);
              },
            );
          },
        ),
        body: SafeArea(
          child: BlocConsumer<GetProfileCubit, GetProfileState>(
            listener: (context, state) {
              if (state.status == CubitStatus.success && state.profile != null) {
                fillFormWithProfileData(state.profile!);
              }
            },
            builder: (context, state) {
              if (state.status == CubitStatus.loading) {
                return const EditProfileShimmer();
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(AppWidthManager.w3Point8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppHeightManager.h4,
                      ),
                      TitleAppFormFiled(
                        isRequired: true,
                        hint: "fullName".tr(),
                        title: "fullName".tr(),
                        initValue: editProfileRequestEntity.fullName,
                        onChanged: (value) {
                          editProfileRequestEntity =
                              editProfileRequestEntity.copyWith(fullName: value);
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
                        hint: "email".tr(),
                        initValue: editProfileRequestEntity.email,
                        title: "email".tr(),
                        onChanged: (value) {
                          editProfileRequestEntity =
                              editProfileRequestEntity.copyWith(email: value);
                          return null;
                        },
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(
                        height: AppHeightManager.h2point5,
                      ),
                      TitleDropDownFormFieldWidget(
                        isRequired: true,
                        title: "gender".tr(),
                        hint: "selectGender".tr(),
                        options: genders,
                        value: selectedGender,
                        onChanged: (NameAndId? value) {
                          setState(() {
                            selectedGender = value;
                          });
                          editProfileRequestEntity = editProfileRequestEntity
                              .copyWith(gender: value?.id);
                        },
                      ),
                      SizedBox(
                        height: AppHeightManager.h2point5,
                      ),
                      TitleCalendarFormField(
                        isRequired: true,
                        title: "dateOfBirth".tr(),
                        color: Colors.black,
                        minDate: DateTime(DateTime.now().year - 100),
                        maxDate: DateTime(DateTime.now().year - 18),
                        hint: selectedDateOfBirth == null
                            ? "selectDateOfBirth".tr()
                            : DateTimeHelper.formatDateWithDash(
                                date: selectedDateOfBirth),
                        initialDate: selectedDateOfBirth,
                        onDateChanged: (DateTime value) {
                          setState(() {
                            selectedDateOfBirth = value;
                          });
                          editProfileRequestEntity =
                              editProfileRequestEntity.copyWith(
                            dateOfBirth: value.toIso8601String(),
                          );
                        },
                      ),
                      SizedBox(
                        height: AppHeightManager.h4,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void fillFormWithProfileData(ProfileResponseEntity profile) {
    if (profile.user != null) {
      setState(() {
        editProfileRequestEntity = editProfileRequestEntity.copyWith(
            fullName: profile.user!.fullName,
            email: profile.user!.email,
            gender: profile.user!.gender,
            dateOfBirth: profile.user!.birthDate);

        selectedGender = genders.firstWhere(
          (gender) => gender.id == profile.user!.gender,
          orElse: () => genders.first,
        );

        selectedDateOfBirth = DateTime.parse(profile.user?.birthDate ?? "");
        print(selectedDateOfBirth);
        print('ggggggggggggggggggggggggggggggg');
      });
    }
  }
}
