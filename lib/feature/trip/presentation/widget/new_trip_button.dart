import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_drive/core/resource/cubit_status_manager.dart';
import 'package:servi_drive/core/widget/container/shimmer_container.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

import '../cubit/new_trip_cubit/new_trip_cubit.dart';
import '../cubit/new_trip_cubit/new_trip_state.dart';
import '../dialog/show_desc_budget_dialog.dart';

class NewTripButton extends StatelessWidget {
  final VoidCallback? onValidationPassed;
  
  const NewTripButton({
    super.key,
    this.onValidationPassed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewTripCubit, NewTripState>(
      listener: (context, state) {
        if (state.status == CubitStatus.error) {
          NoteMessage.showErrorSnackBar(context: context, text: state.error);
        }
      },
      builder: (context, state) {
        if(state.status == CubitStatus.loading){
          return ShimmerContainer(          height: AppHeightManager.h6,
            width: AppWidthManager.w100,);
        }
        return MainAppButton(
          onTap: () {
            if (onValidationPassed != null) {
              onValidationPassed!();
            } else {
              showDescBudgetDialog(context: context);
            }
          },
          height: AppHeightManager.h6,
          width: AppWidthManager.w100,
          color: AppColorManager.lightMainColor,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
              horizontal: AppWidthManager.w3Point8),
          child: AppTextWidget(
            text: "Create Trip Now",
            color: AppColorManager.white,
            fontWeight: FontWeight.w600,
            fontSize: FontSizeManager.fs16,
          ),
        );
      },
    );
  }
}
