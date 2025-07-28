import 'package:flutter/cupertino.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';
import 'app_text_widget.dart';

/// Eng.Nour Othman(meory)*
/// 24 Dec 2024

class TagTextWidget extends StatelessWidget {
  final String title;
  final BorderRadius? borderRadius;
  const TagTextWidget({super.key,required this.title, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return  Container(

      height: AppHeightManager.h4point4,
      padding: EdgeInsets.symmetric(
          vertical: AppHeightManager.h1,
          horizontal: AppWidthManager.w2),
      decoration: BoxDecoration(
          borderRadius:borderRadius??
          BorderRadius.circular(AppRadiusManager.r5),
          color: AppColorManager.tagColor),
      child: AppTextWidget(
        text: title,
        textAlign: TextAlign.center,
        fontSize: FontSizeManager.fs14,
        fontWeight: FontWeight.w500,
        color: AppColorManager.white,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
