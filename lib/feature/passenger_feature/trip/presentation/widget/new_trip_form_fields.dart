import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/drop_down/title_drop_down_form_field.dart';
import 'package:servi_drive/core/widget/form_field/title_app_form_filed.dart';
import 'package:servi_drive/core/widget/form_field/title_calendar_form_field.dart';
import 'package:servi_drive/core/widget/form_field/title_time_form_field.dart';

import '../../../../../core/resource/color_manager.dart';

class NewTripFormFields extends StatelessWidget {
  final TextEditingController travellers;
  final TextEditingController luggage;
  final int travellerCount;
  final int luggageCount;final bool fast;
  final ValueChanged<int> onTravellerCountChanged;
  final ValueChanged<int> onLuggageCountChanged;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const NewTripFormFields({
    super.key,
    required this.travellers,
    required this.luggage,
    required this.travellerCount,
    required this.fast,
    required this.luggageCount,
    required this.onTravellerCountChanged,
    required this.onLuggageCountChanged,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleDropDownFormFieldWidget(
          isRequired: true,
          hint: "Trip Route".tr(),
          title: "Trip Route".tr(),
          options: [],
        ),
        SizedBox(
          height: AppHeightManager.h1point8,
        ),
        Row(
          children: [
            Expanded(
              child: TitleCalendarFormField(
                isRequired: true,
                title: "Date".tr(),
                onDateChanged: onDateChanged,
                hint: "Date".tr(),
              ),
            ),
            SizedBox(
              width: AppWidthManager.w2,
            ),
            Expanded(
              child: TitleTimeFormField(
                title: "Time".tr(),
                isRequired: true,
                hint: "Time".tr(),
                onTimeChanged: onTimeChanged,
              ),
            )
          ],
        ),
        SizedBox(
          height: AppHeightManager.h1point8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: TitleAppFormFiled(
                isRequired: true,
                initValue: travellers.text,
                hint: "Travellers".tr(),
                readOnly: true,
                title: "Travellers".tr(),
                onChanged: (value) {
                  return null;
                },
                validator: (value) {
                  return null;
                },
              ),
            ),
            SizedBox(
              width: AppWidthManager.w2,
            ),
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColorManager.lightMainColor,
                    child: Center(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          onTravellerCountChanged(travellerCount + 1);
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppWidthManager.w2,
                  ),
                  CircleAvatar(
                    backgroundColor: travellerCount == 1
                        ? AppColorManager.lightGreyOpacity6
                        : AppColorManager.darkMainColor,
                    child: Center(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          if (travellerCount == 1) return;
                          onTravellerCountChanged(travellerCount - 1);
                        },
                        icon: Icon(
                          Icons.remove,
                          color: travellerCount == 1
                              ? AppColorManager.grey
                              : Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: AppHeightManager.h1point8,
        ),
        Visibility(
          visible: fast==false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: TitleAppFormFiled(
                  initValue: luggage.text,
                  hint: "Luggage ".tr(),
                  readOnly: true,
                  title: "Luggage ".tr(),
                  onChanged: (value) {
                    return null;
                  },
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: AppWidthManager.w2,
              ),
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColorManager.lightMainColor,
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: () {
                            onLuggageCountChanged(luggageCount + 1);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppWidthManager.w2,
                    ),
                    CircleAvatar(
                      backgroundColor: luggageCount == 0
                          ? AppColorManager.lightGreyOpacity6
                          : AppColorManager.darkMainColor,
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: () {
                            if (luggageCount == 0) return;
                            onLuggageCountChanged(luggageCount - 1);
                          },
                          icon: Icon(
                            Icons.remove,
                            color: luggageCount == 0
                                ? AppColorManager.grey
                                : Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
