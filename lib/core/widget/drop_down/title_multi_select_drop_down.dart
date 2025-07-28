import 'package:servi_drive/core/widget/drop_down/multi_select_drop_down_form_field.dart';
import 'package:flutter/cupertino.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';
import '../text/app_text_widget.dart';
import '../text/required_text_widget.dart';
import 'NameAndId.dart';

///
/// created by eng nour othman
/// at 9/3/2025
///
class TitleMultiSelectDropDown extends StatelessWidget {
  final String title, hint;
  final List<NameAndId> options;
  final List<NameAndId> selectedOptions;
  final String? Function(List<NameAndId>?)? validator;
  final Function(List<NameAndId>?)? onChanged;
  final bool? isRequired;
  final Color? borderColor;

  const TitleMultiSelectDropDown(
      {super.key,
      required this.hint,
      required this.title,
      this.validator,
      this.borderColor,
      this.isRequired,
      required this.selectedOptions,
      this.onChanged,
      required this.options});

  @override
  Widget build(BuildContext context) {
    // Determine if the field is invalid by running the validator
    final bool isInvalid =
        validator != null && validator!(selectedOptions) != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isRequired == true
            ? RequiredTextWidget(
                title: title,
                color: AppColorManager.textAppColor,
              )
            : AppTextWidget(
                text: title,
                fontSize: FontSizeManager.fs16,
                fontWeight: FontWeight.w600,
                color: AppColorManager.textAppColor,
              ),
        SizedBox(
          height: AppHeightManager.h1point5,
        ),
        MultiSelectDropDownWidget(
          selectedValues: selectedOptions,
          hint: hint,
          options: options,
          onChanged: onChanged,
          borderColor: isInvalid ? AppColorManager.red : borderColor,
          validator: validator,
        )
      ],
    );
  }
}
