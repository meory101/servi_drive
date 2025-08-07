import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/widget/container/shimmer_container.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/edit_trip_cubit/edit_trip_cubit.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/cubit/edit_trip_cubit/edit_trip_state.dart';
import 'package:servi_drive/router/router.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/screen/trip_offers_screen.dart';
import 'package:servi_drive/core/model/trip_data.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/enum_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

class PendingTripActions extends StatelessWidget {
  final TripData tripData;
  
  const PendingTripActions({super.key, required this.tripData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MainAppButton(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
            borderRadius: BorderRadius.circular(AppRadiusManager.r15),
            height: AppHeightManager.h6point6,
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteNamedScreens.tripOffers,
                arguments: TripOffersArgs(
                  tripId: tripData.id ?? '',
                  tripData: tripData,
                ),
              );
            },
            color: AppColorManager.lightMainColor,
            borderColor: AppColorManager.mainColor,
            alignment: Alignment.center,
            child: AppTextWidget(
              text: "Check Offers".tr(),
              fontSize: FontSizeManager.fs16,
              color: AppColorManager.white,
            ),
          ),
        ),
        SizedBox(
          width: AppWidthManager.w3Point8,
        ),
        Expanded(
          child: BlocConsumer<EditTripCubit, EditTripState>(
            listener: (context, state) {
              if(state.status == CubitStatus.error){
                NoteMessage.showErrorSnackBar(context: context, text: state.error);
              }
            },
            builder: (context, state) {
              if(state.status ==CubitStatus.loading){
                return ShimmerContainer(width: AppWidthManager.w100, height: AppHeightManager.h6point6);
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
                borderColor: AppColorManager.mainColor,
                alignment: Alignment.center,
                child: AppTextWidget(
                  text: "Close Trip".tr(),
                  fontSize: FontSizeManager.fs16,
                  color: AppColorManager.mainColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
