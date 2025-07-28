import 'package:flutter/material.dart';

abstract class AppColorManager {

  static const Color darkMainColor = Color(0xff14191F	);
  static const Color lightMainColor = Color(0xFF2DBE60);
  static const Color background = Color(0xFFF8F9FA);
  static const Color mainGreyColor = Color(0xffEFF4F5);
  static const Color mainColor = Color(0xFF2DBE60);
  static  Color gradientColor = Color(0xFF2DBE60).withOpacity(0.9);

  // static const Color mainColor = Color(0xff624099);


  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color shadow = Color.fromARGB(28, 130, 130, 130);
  static Color tagColor = AppColorManager.darkMainColor.withValues(alpha: 0.8);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  // static const Color lightMainColor = Color(0xffF1EDF7);
  static const Color blue = Color(0xff265BFF);
  static const Color dotGrey = Color(0xffE5E5EA);
  static const Color textGrey = Color(0xff8E8E93);
  static const Color borderGrey = Color(0xffD1D1D6);
  static const Color hintGrey = Color(0xffAEAEB2);
  static const Color grey = Color(0xff8e8e93);
  static const Color yellow = Color(0xffFFCC00);
  static const Color textAppColor = Color(0xff171717);
  static const Color shimmerHighlightColor = Color(0xfff5f5f5); // very light
  static const Color shimmerBaseColor = Color(0xffe0e0e0);
  static Color redOpacity15 = const Color(0xffff3b30).withOpacity(0.15);
  static Color greenOpacity15 = const Color(0xff34c759).withOpacity(0.15);
  static const Color red = Color(0xffFF3B30);
  static Color lightGreyOpacity6 = const Color(0xffe5e5ea).withOpacity(0.6);
  static const Color green = Color(0xff34C759);
  static const Color orange = Color(0xffFF9500);
  static const Color grayscale = Color(0xffF2F2F7);
}
