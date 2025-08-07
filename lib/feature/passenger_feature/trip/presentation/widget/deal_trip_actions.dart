import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/resource/enum_manager.dart';
import 'package:servi_drive/core/widget/container/shimmer_container.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/edit_trip_cubit/edit_trip_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/edit_trip_cubit/edit_trip_state.dart';
import 'package:servi_drive/router/router.dart';
import '../../../../../core/model/trip_data.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/image_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/container/decorated_container.dart';
import '../../../../../core/widget/image/main_image_widget.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

class DealTripActions extends StatelessWidget {
  final TripData tripData;
  const DealTripActions({super.key,required this.tripData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedContainer(
          padding: EdgeInsets.all(AppWidthManager.w3Point8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNamedScreens.driverInfo);
                },
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: AppWidthManager.w14,
                      width: AppWidthManager.w14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColorManager.darkMainColor,
                      ),
                      child: MainImageWidget(
                        imagePath: AppImageManager.placeholder,
                      ),
                    ),
                    SizedBox(width: AppWidthManager.w1Point8),
                    AppTextWidget(
                      text: "Driver Name",
                      color: AppColorManager.darkMainColor,
                      fontSize: FontSizeManager.fs16,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: AppRadiusManager.r20,
                    child: Icon(
                      Icons.call,
                      color: AppColorManager.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: AppHeightManager.h2,
        ),
        BlocConsumer<EditTripCubit, EditTripState>(
          listener: (context, state) {
            if (state.status == CubitStatus.error) {
              NoteMessage.showErrorSnackBar(
                  context: context, text: state.error);
            }
          },
          builder: (context, state) {
            if (state.status == CubitStatus.loading) {
              return ShimmerContainer(
                  width: AppWidthManager.w100,
                  height: AppHeightManager.h6point6);
            }
            return MainAppButton(
              padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
              borderRadius: BorderRadius.circular(AppRadiusManager.r15),
              height: AppHeightManager.h6point6,
              onTap: () {
                tripData.status = EnumManager.canceledTripCode;
                context.read<EditTripCubit>().editTrip(
                    context: context, tripId: tripData.id??"" , tripData: tripData);
              },
              outLinedBorde: true,
              color: AppColorManager.darkMainColor,
              borderColor: AppColorManager.red,
              alignment: Alignment.center,
              child: AppTextWidget(
                text: "Cancel Trip".tr(),
                fontSize: FontSizeManager.fs16,
                color: AppColorManager.red,
              ),
            );
          },
        )
      ],
    );
  }
}
