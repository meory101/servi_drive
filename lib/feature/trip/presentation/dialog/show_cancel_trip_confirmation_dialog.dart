import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/core/model/trip_data.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/resource/enum_manager.dart';
import 'package:servi_drive/core/widget/container/shimmer_container.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';

import '../../../../../core/injection/injection_container.dart' as di;
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
import '../cubit/edit_trip_cubit/edit_trip_cubit.dart';
import '../cubit/edit_trip_cubit/edit_trip_state.dart';

void showCancelTripConfirmationDialog({
  required BuildContext context,
  required TripData tripData,
}) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocProvider(
        create: (context) => di.sl<EditTripCubit>(),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppRadiusManager.r20)),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: AppWidthManager.w4,
          ),
          elevation: 0,
          backgroundColor: AppColorManager.white,
          child: Padding(
            padding: EdgeInsets.all(AppWidthManager.w3Point8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppHeightManager.h2point5),
                AppTextWidget(
                  text: "Cancel Trip".tr(),
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeManager.fs18,
                  overflow: TextOverflow.visible,
                  color: AppColorManager.red,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppHeightManager.h2),
                AppTextWidget(
                  text:
                      "Are you sure you want to cancel this trip? This action cannot be undone."
                          .tr(),
                  fontWeight: FontWeight.w500,
                  fontSize: FontSizeManager.fs15,
                  color: AppColorManager.grey,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppHeightManager.h4),
                Row(
                  children: [
                    Expanded(
                      child: MainAppButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidthManager.w10),
                        borderRadius:
                            BorderRadius.circular(AppRadiusManager.r15),
                        height: AppHeightManager.h6,
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                        },
                        alignment: Alignment.center,
                        child: AppTextWidget(
                          text: "Cancel".tr(),
                          fontSize: FontSizeManager.fs16,
                          color: AppColorManager.lightMainColor,
                        ),
                      ),
                    ),
                    SizedBox(width: AppWidthManager.w1Point2),
                    Expanded(
                      child: BlocConsumer<EditTripCubit, EditTripState>(
                        listener: (blocContext, state) {
                          if (state.status == CubitStatus.error) {
                            NoteMessage.showErrorSnackBar(
                                context: context, text: state.error);
                          }
                          if (state.status == CubitStatus.success) {
                            Navigator.of(dialogContext).pop(); // Close dialog
                            Navigator.of(context)
                                .pop(); // Close trip details screen
                            NoteMessage.showSuccessSnackBar(
                                context: context,
                                text: "Trip canceled successfully".tr());
                          }
                        },
                        builder: (blocContext, state) {
                          if (state.status == CubitStatus.loading) {
                            return ShimmerContainer(
                              width: AppWidthManager.w100,
                              height: AppHeightManager.h6,
                            );
                          }
                          return MainAppButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppWidthManager.w10),
                            borderRadius:
                                BorderRadius.circular(AppRadiusManager.r15),
                            height: AppHeightManager.h6,
                            onTap: () {
                              final updatedTripData = tripData.copyWith(
                                status: EnumManager.canceledTripCode,
                              );
                              blocContext.read<EditTripCubit>().editTrip(
                                    context: context,
                                    tripId: tripData.id ?? "",
                                    tripData: updatedTripData,
                                  );
                            },
                            outLinedBorde: true,
                            borderColor: AppColorManager.red,
                            alignment: Alignment.center,
                            child: AppTextWidget(
                              text: "Confirm".tr(),
                              fontSize: FontSizeManager.fs16,
                              color: AppColorManager.red,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppHeightManager.h2point5),
              ],
            ),
          ),
        ),
      );
    },
  );
}
