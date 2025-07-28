import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resource/color_manager.dart';
import '../../resource/size_manager.dart';
import 'app_text_widget.dart';

class ViewsTextWidget extends StatelessWidget {
 final  String? views;
  const ViewsTextWidget({super.key,this.views});

  @override
  Widget build(BuildContext context) {
    return    Row(
      children: [
        AppTextWidget(
          text: (views??"").toString(),
          color: AppColorManager.grey,
        )
        ,
        SizedBox(width: AppWidthManager.w1,),
        Icon(
          Icons.remove_red_eye_outlined,
          size: 16,
          color: AppColorManager.grey,
        ),

      ],
    );
  }
}
