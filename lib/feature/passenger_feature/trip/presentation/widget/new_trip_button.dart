import 'package:flutter/cupertino.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

import '../dialog/show_desc_budget_dialog.dart';

class NewTripButton extends StatelessWidget {
  const NewTripButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  MainAppButton(
      onTap: () {
        showDescBudgetDialog(context: context);
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
  }
}
