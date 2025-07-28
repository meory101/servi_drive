import 'package:flutter/cupertino.dart';

import '../../resource/color_manager.dart';
import '../../resource/size_manager.dart';

class DragContainer extends StatelessWidget {
  const DragContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: AppWidthManager.w14,
      height: AppHeightManager.h1,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(AppRadiusManager.r10),
          color: AppColorManager.grey.withAlpha(120)),
    );
  }
}
