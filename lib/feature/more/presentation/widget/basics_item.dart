import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/helper/language_helper.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/icon_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/container/decorated_container.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

class BasicsItem extends StatelessWidget {
  const BasicsItem({super.key, required this.title, required this.onTap});

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(AppColorManager.transparent),
      onTap: onTap,
      child: DecoratedContainer(
        borderRadius: BorderRadius.circular(AppRadiusManager.r15),
        padding: EdgeInsets.symmetric(
            horizontal: AppWidthManager.w5, vertical: AppHeightManager.h3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppTextWidget(
                  text: title,
                  fontSize: FontSizeManager.fs16,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(
              height: AppHeightManager.h2point5,
              width: AppHeightManager.h2point5,
              child: SvgPicture.asset(
                LanguageHelper.checkIfLTR(context: context)
                    ? AppIconManager.arrowMenuRight
                    : AppIconManager.arrowMenuLeft,
                colorFilter: ColorFilter.mode(
                    AppColorManager.darkMainColor, BlendMode.srcIn),
              ),
            )
          ],
        ),
      ),
    );
  }
}
