import 'package:servi_drive/core/resource/color_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:dotted_button/dotted_button.dart';
import 'package:flutter/cupertino.dart';

///
/// created by eng hussaen baghdadi ***
/// at 11/5/2025
///

class MainAppDottedButton extends StatelessWidget {
  final Function()? onTap;
  final Color? color;
  final double? height;
  final double? width;
  final Widget? child;
  final Color? dotColor;
  final double? borderRadius;

  const MainAppDottedButton(
      {super.key,
      this.onTap,
      this.color,
      this.height,
      this.width,
      this.child,
      this.dotColor,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return DottedButton(margin: EdgeInsets.all(AppWidthManager.w1),
      dashColor: dotColor ?? AppColorManager.mainColor,
      borderRadius: borderRadius ?? AppRadiusManager.r16,
      strokeWidth: 1,
      dashPattern: const [6, 9],
      onTap: onTap,
      height: height ?? AppHeightManager.h6point6,
      width: width ?? AppWidthManager.w100,
      borderType: BorderType.RRect,
      color: color ?? AppColorManager.white,
      child: child ?? const SizedBox(),
    );
  }
}
