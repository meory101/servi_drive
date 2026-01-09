import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resource/color_manager.dart';
import '../../resource/size_manager.dart';

class CircularBackButton extends StatefulWidget {
  const CircularBackButton({super.key});

  @override
  State<CircularBackButton> createState() => _CircularBackButtonState();
}

class _CircularBackButtonState extends State<CircularBackButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColorManager.lightGreyOpacity6,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,

              size: AppWidthManager.w6,
              color: AppColorManager.lightMainColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        )
      ],
    );
  }
}
