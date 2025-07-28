import 'package:flutter/cupertino.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';

///
/// created by eng hussaen baghdadi ***
/// at 11/5/2025
///

class RequiredTextWidget extends StatelessWidget {
  final String title;
  final Color? color;

  const RequiredTextWidget({super.key, required this.title,this.color});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: title,
          style: TextStyle(
              color:color?? AppColorManager.textAppColor,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamilyManager.cairo,
              fontSize: FontSizeManager.fs16),
          children: [
            TextSpan(
              text: ' *',
              style: TextStyle(
                  color: AppColorManager.lightMainColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamilyManager.cairo,
                  fontSize: FontSizeManager.fs16),
            )
          ]),
    );
  }
}
