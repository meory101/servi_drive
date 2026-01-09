import 'package:flutter/cupertino.dart';
import 'package:servi_drive/core/widget/container/shimmer_container.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

class HomeAppBarShimmer extends StatelessWidget {
  const HomeAppBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: AppWidthManager.w13,
          width: AppWidthManager.w13,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColorManager.dotGrey,
          ),
          child: ShimmerContainer(
            height: AppWidthManager.w13,
            width: AppWidthManager.w13,          ),
        ),
        SizedBox(
          width: AppWidthManager.w2,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppHeightManager.h1,),
          ShimmerContainer(width: AppWidthManager.w45, height: AppHeightManager.h1point8),
          SizedBox(height: AppHeightManager.h1,),
          ShimmerContainer(width: AppWidthManager.w20, height: AppHeightManager.h1point8),

          ],
        )
      ],
    );
  }
}
