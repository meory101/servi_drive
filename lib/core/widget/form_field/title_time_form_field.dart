import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../helper/language_helper.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/icon_manager.dart';
import '../../resource/size_manager.dart';
import '../text/app_text_widget.dart';

class TitleTimeFormField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(TimeOfDay) onTimeChanged;
  final Color? color;
  final TimeOfDay? initialTime;
  final bool isRequired;

  const TitleTimeFormField({
    super.key,
    required this.title,
    required this.onTimeChanged,
    required this.hint,
    this.initialTime,
    this.color,
    this.isRequired = false,
  });

  @override
  State<TitleTimeFormField> createState() => _TitleTimeFormFieldState();
}

class _TitleTimeFormFieldState extends State<TitleTimeFormField> {
  TimeOfDay? selectedTime;

  Future<void> showTimePickerDialog() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: widget.initialTime ?? now,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
      widget.onTimeChanged(picked);
    }
  }

  String getTimeText() {
    if (selectedTime != null) {
      final hour = selectedTime!.hourOfPeriod.toString().padLeft(2, '0');
      final minute = selectedTime!.minute.toString().padLeft(2, '0');
      final period = selectedTime!.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }
    return widget.hint;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppTextWidget(
              text: widget.title,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.w600,
            ),
            if (widget.isRequired)
              const Text(
                ' *',
                style: TextStyle(color: AppColorManager.lightMainColor),
              ),
          ],
        ),
        SizedBox(height: AppHeightManager.h1),
        InkWell(
          overlayColor:
              const WidgetStatePropertyAll(AppColorManager.transparent),
          onTap: showTimePickerDialog,
          child: Container(
            alignment: LanguageHelper.checkIfLTR(context: context)
                ? Alignment.topRight
                : Alignment.topLeft,
            width: double.infinity,
            height: AppHeightManager.h6,
            decoration: BoxDecoration(
              color: AppColorManager.mainGreyColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(AppRadiusManager.r10)),
              border: Border.all(color: AppColorManager.lightGreyOpacity6),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppWidthManager.w3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: getTimeText(),
                    fontSize: FontSizeManager.fs15,
                    fontWeight: FontWeight.w500,
                    color: widget.color ??
                        (selectedTime != null
                            ? AppColorManager.textAppColor
                            : AppColorManager.hintGrey),
                  ),
                  InkWell(
                    overlayColor: const WidgetStatePropertyAll(
                        AppColorManager.transparent),
                    onTap: showTimePickerDialog,
                    child: SvgPicture.asset(AppIconManager.clock,
                        colorFilter: ColorFilter.mode(
                            AppColorManager.lightMainColor, BlendMode.srcIn)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
