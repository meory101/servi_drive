import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../helper/language_helper.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/icon_manager.dart';
import '../../resource/size_manager.dart';
import '../text/app_text_widget.dart';

///
/// created by eng nour othman ***
/// at 10/2/2025
///

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar(
      {super.key,
      required this.title,
      this.actions,
      this.color,
      this.showArrowBack});

  final String title;
  final List<Widget>? actions;
  final Color? color;
  final bool? showArrowBack;

  @override
  Size get preferredSize => Size.fromHeight(AppHeightManager.h10);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColorManager.white,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(top: AppHeightManager.h2point5),
        child: Row(
          children: [
            Visibility(
              visible: (showArrowBack ?? true) == true,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  LanguageHelper.checkIfLTR(context: context)
                      ? AppIconManager.arrowLeft
                      : AppIconManager.arrowRight,
                  colorFilter: const ColorFilter.mode(
                      AppColorManager.black, BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(
              width: AppWidthManager.w2,
            ),
            AppTextWidget(
              text: title,
              fontSize: FontSizeManager.fs18,
              color: AppColorManager.black,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      backgroundColor: color,
      actions: [
        Padding(
          padding: EdgeInsets.only(top: AppHeightManager.h2point5),
          child: Row(
            children: actions ?? [],
          ),
        )
      ],
      elevation: 0,
    );
  }
}
