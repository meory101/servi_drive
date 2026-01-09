import 'package:servi_drive/core/resource/color_manager.dart';
import 'package:servi_drive/core/resource/font_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/button/main_app_button.dart';
import 'package:servi_drive/core/widget/text/app_text_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 

void showWheelDatePicker({
  required BuildContext context,
  DateTime? initialDateTime,
  DateTime? minimumDate,
  DateTime? maximumDate,
  required Function(DateTime) onDateSelected,
}) {
  final DateTime initial = () {
    if (initialDateTime != null) {
      if (minimumDate != null && initialDateTime.isBefore(minimumDate)) {
        return minimumDate;
      }
      if (maximumDate != null && initialDateTime.isAfter(maximumDate)) {
        return maximumDate;
      }
      return initialDateTime;
    } else {
      final now = DateTime.now();
      if (maximumDate != null && now.isAfter(maximumDate)) {
        return maximumDate;
      }
      if (minimumDate != null && now.isBefore(minimumDate)) {
        return minimumDate;
      }
      return now;
    }
  }();

  DateTime selectedDate = initial;

  showModalBottomSheet(
    context: context,
    backgroundColor: AppColorManager.white,
    builder: (BuildContext builder) {
      return SafeArea(
        top: false,
        bottom: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadiusManager.r10),
            color: AppColorManager.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                height: AppHeightManager.h30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                  color: AppColorManager.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w5),
                  child: CupertinoDatePicker(
                    initialDateTime: initial,
                    onDateTimeChanged: (DateTime pickedDate) {
                      selectedDate = pickedDate;
                    },
                    itemExtent: AppHeightManager.h5,
                    mode: CupertinoDatePickerMode.date,
                    minimumDate: minimumDate,
                    maximumDate: maximumDate,
                    use24hFormat: true,
                  ),
                ),
              ),
              SizedBox(height: AppHeightManager.h2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainAppButton(
                    width: MediaQuery.of(context).size.width / 2.6,
                    borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                    height: AppHeightManager.h5,
                    onTap: () {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd', 'en_US').format(selectedDate);
                      DateTime finalDate = DateTime.parse(formattedDate);
                      onDateSelected(finalDate);
                      Navigator.of(context).pop();
                    },
                    color: AppColorManager.mainColor,
                    alignment: Alignment.center,
                    child: AppTextWidget(
                      text: "save".tr(),
                      fontSize: FontSizeManager.fs16,
                      color: AppColorManager.white,
                    ),
                  ),
                  SizedBox(width: AppWidthManager.w2),
                  MainAppButton(
                    width: MediaQuery.of(context).size.width / 2.6,
                    borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                    height: AppHeightManager.h5,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    color: AppColorManager.white,
                    alignment: Alignment.center,
                    child: AppTextWidget(
                      text: "cancel".tr(),
                      fontSize: FontSizeManager.fs16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppHeightManager.h2),
            ],
          ),
        ),
      );
    },
  );
}
                                                                                                      