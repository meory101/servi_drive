import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';
import 'package:flutter/material.dart';


class StatusText extends StatelessWidget {
  const StatusText({super.key, required this.color, required this.text});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(
          horizontal: AppWidthManager.w3, vertical: AppHeightManager.h02),
      child: AppTextWidget(
        text: text,
        fontSize: FontSizeManager.fs15,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}