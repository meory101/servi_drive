import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/container/decorated_container.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

/// Eng.Nour Othman(meory)*
/// 24 Dec 2024
class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.onTap,
      required this.title,
        this.fontSize,
      this.isDeleteItem = false});
  final String title;
  final Function() onTap;
  final bool isDeleteItem;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(AppColorManager.transparent),
      onTap: onTap,
      child:
      DecoratedContainer(
        height: AppHeightManager.h4,
        borderRadius: BorderRadius.circular(AppRadiusManager.r15),
        padding: EdgeInsets.symmetric(horizontal:  AppWidthManager.w5,vertical: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: AppTextWidget(
                      text: title,
                      fontSize:fontSize?? FontSizeManager.fs15,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                      color: isDeleteItem
                          ? AppColorManager.red
                          : AppColorManager.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
