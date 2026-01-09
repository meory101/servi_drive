import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/text/app_text_widget.dart';


class ResendVerificationWidget extends StatefulWidget {
  const ResendVerificationWidget({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ResendVerificationWidgetState createState() =>
      _ResendVerificationWidgetState();
}

class _ResendVerificationWidgetState extends State<ResendVerificationWidget> {
  int _remainingSeconds = 0;
  StreamSubscription<int>? _timerSubscription;
  final int startTime = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingSeconds = startTime;
    _timerSubscription =
        Stream.periodic(const Duration(seconds: 1), (i) => i).listen((event) {
      setState(() {
        _remainingSeconds = startTime - (event % startTime);
      });
      if (_remainingSeconds == 1) {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    setState(() {
      _remainingSeconds = 0;
    });
  }

  void resetTimer() {
    _stopTimer();
    _startTimer();
  }

  @override
  void dispose() {
    _timerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: _remainingSeconds != 0,
          replacement: MainAppButton(
            onTap: () {

            },
            child: AppTextWidget(
              text: "resend".tr(),
              onTap: () {
                _startTimer();
              },
              fontSize: FontSizeManager.fs16,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                overflow: TextOverflow.clip,
                softWrap: true,
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "resend".tr(),
                  style: TextStyle(
                    fontFamily: FontFamilyManager.cairo,
                    fontSize: FontSizeManager.fs16,
                    color: AppColorManager.textAppColor,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: "  "),
                    TextSpan(
                        text: "$_remainingSeconds ${"second".tr()}",
                        style: TextStyle(
                          fontFamily: FontFamilyManager.cairo,
                          fontSize: FontSizeManager.fs16,
                          fontWeight: FontWeight.w600,
                          color: AppColorManager.mainColor,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
