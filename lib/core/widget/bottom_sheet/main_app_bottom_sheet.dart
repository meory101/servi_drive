import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:flutter/cupertino.dart';
 import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../button/main_app_button.dart';
import '../../../core/widget/text/app_text_widget.dart';

class MainAppBottomSheet extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const MainAppBottomSheet({super.key,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: AppHeightManager.h10,
        decoration: BoxDecoration(
          color: AppColorManager.white,
          boxShadow: [
            BoxShadow(
              color: AppColorManager.shadow,
              offset: Offset(-6, -6),
              spreadRadius: 5,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadiusManager.r20),
            topRight: Radius.circular(AppRadiusManager.r20),
          ),
        ),
        child: MainAppButton(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
          borderRadius: BorderRadius.circular(AppRadiusManager.r15),
          height: AppHeightManager.h6point6,
          margin: EdgeInsets.all(AppWidthManager.w3Point8),
          onTap:onTap,
          gradientColors: [
            AppColorManager.mainColor,
            AppColorManager.mainColor,
          ],
          alignment: Alignment.center,
          child: AppTextWidget(
            text:title,
            fontSize: FontSizeManager.fs16,
            color: AppColorManager.white,
          ),
        ),
      ),
    );
  }
}
