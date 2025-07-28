import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_action/slide_action.dart';
import '../../resource/font_manager.dart';
import '../../resource/icon_manager.dart';
import '../../resource/size_manager.dart';
import '../loading/app_circular_progress_widget.dart';
import '../text/app_text_widget.dart';

///
/// created by eng nour othman ***
/// at 10/2/2025
///
///

class SlideButton extends StatelessWidget {
  const SlideButton(
      {super.key,
      required this.buttonColor,
      required this.slideText,
      required this.loadingText,
      required this.action,
      this.isLoading});

  final Color buttonColor;
  final String loadingText, slideText;
  final Function() action;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeightManager.h8,
      padding: EdgeInsets.symmetric(vertical: AppHeightManager.h05),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadiusManager.r40),
          color: buttonColor.withOpacity(0.1)),
      child: SlideAction(
        rightToLeft: true,
        trackBuilder: (context, state) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: AppWidthManager.w5,
                ),
                AppTextWidget(
                  text: state.isPerformingAction ? loadingText : slideText,
                  fontSize: FontSizeManager.fs16,
                  color: buttonColor,
                ),
                // SvgPicture.asset(
                //   AppIconManager.add,
                //   colorFilter: ColorFilter.mode(buttonColor, BlendMode.srcIn),
                // ),
                SizedBox(
                  width: AppWidthManager.w2,
                ),
                SizedBox(
                  width: AppWidthManager.w2,
                ),
              ],
            ),
          );
        },
        thumbBuilder: (context, state) {
          return Container(
            margin: EdgeInsets.all(AppWidthManager.w1),
            child: Container(
              decoration: BoxDecoration(
                color: buttonColor,
                shape: BoxShape.circle,
              ),
              child:  isLoading == true
                      ? Center(child: AppCircularProgressWidget(color: Colors.white,))
                      : Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
            ),
          );
        },
        action: action,
      ),
    );
  }
}
