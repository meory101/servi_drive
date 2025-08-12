import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/resource/icon_manager.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';
import 'package:servi_drive/feature/passenger_feature/home/presentation/shimmer/home_app_bar_shiummer.dart';
import 'package:servi_drive/feature/passenger_feature/more/presentation/cubit/get_profile_cubit/get_profile_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/more/presentation/cubit/get_profile_cubit/get_profile_state.dart';

import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/image_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/image/main_image_widget.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

class DriverHomeAppBar extends StatelessWidget {
  const DriverHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: AppHeightManager.h8,
          bottom: AppHeightManager.h1point8,
          left: AppWidthManager.w3Point8,

          right: AppWidthManager.w3Point8),
      height: AppHeightManager.h17,
      decoration: BoxDecoration(
          color: AppColorManager.darkMainColor,
          borderRadius: BorderRadius.circular(AppRadiusManager.r20)
      ),
      child: BlocConsumer<GetProfileCubit, GetProfileState>(
        listener: (context, state) {
          if(state.status == CubitStatus.error){
            NoteMessage.showErrorSnackBar(context: context, text: state.error);
          }
        },
        builder: (context, state) {
          if(state.status == CubitStatus.loading){
            return HomeAppBarShimmer() ;
          }
          return Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: AppWidthManager.w13,
                    width: AppWidthManager.w13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColorManager.dotGrey,
                    ),
                    child: MainImageWidget(
                      imageUrl: state.profile?.user?.image??"",
                      imagePath: AppImageManager.placeholder,
                    ),
                  ),
                  SizedBox(
                    width: AppWidthManager.w2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppHeightManager.h1,),
                      AppTextWidget(
                        text: "Hello ${state.profile?.user?.fullName??""}",
                        color: AppColorManager.white,
                        fontSize: FontSizeManager.fs18,
                        fontWeight: FontWeight.w700,
                      ),
                      AppTextWidget(
                        text: "make new offers today",
                        fontSize: FontSizeManager.fs15,
                        fontWeight: FontWeight.w500,
                        color: AppColorManager.textGrey,
                      ),
                    ],
                  )
                ],
              ),
              SvgPicture.asset(AppIconManager.more)
            ],
          );
        },
      ),
    );
  }
}
