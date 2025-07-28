import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/icon_manager.dart';
import '../../resource/size_manager.dart';
import '../text/app_text_widget.dart';
import 'NameAndId.dart';

///
/// created by eng nour othman
/// at 9/3/2025
///

class DropDownFormFieldWidget extends StatefulWidget {
  const DropDownFormFieldWidget({
    super.key,
    required this.options,
    required this.hint,
    this.hintFontColor,
    this.hintFontSize,
    this.hintFontWeight,
    this.reset,
    this.validator,
    this.iconColor,
    this.icon,
    this.width,
    this.iconSize,
    this.borderColor,
    this.value,
    this.onChanged,
    this.readOnly = false,
  });

  final List<NameAndId> options;
  final String hint;
  final bool? reset;
  final Color? hintFontColor;
  final FontWeight? hintFontWeight;
  final double? hintFontSize;
  final NameAndId? value;
  final Color? borderColor;
  final double? width;
  final double? iconSize;
  final Color? iconColor;
  final Widget? icon;
  final String? Function(NameAndId?)? validator;
  final Function(NameAndId?)? onChanged;
  final bool readOnly;

  @override
  State<DropDownFormFieldWidget> createState() =>
      _DropDownFormFieldWidgetState();
}

class _DropDownFormFieldWidgetState extends State<DropDownFormFieldWidget> {
  NameAndId? nameAndIdObject;

  @override
  void initState() {
    super.initState();
    nameAndIdObject = widget.value;
  }

  @override
  void didUpdateWidget(covariant DropDownFormFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      setState(() {
        nameAndIdObject = null;
      });
    }
    if (oldWidget.value != widget.value) {
      setState(() {
        nameAndIdObject = widget.value;
      });
    }
  }

  GlobalKey<FormFieldState> dropDownKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<NameAndId>(
          value: nameAndIdObject,
          validator: widget.validator,

          icon: const SizedBox(),
          decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: FontSizeManager.fs14),
            contentPadding:
                EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
            suffixIcon:widget.icon?? Padding(
              padding: const EdgeInsets.all(19.0),

              child: SizedBox(
                height: AppHeightManager.h1,
                width: AppHeightManager.h1,
                child: SvgPicture.asset(AppIconManager.arrowMenuDown),
              ),
            ),
            fillColor: AppColorManager.mainGreyColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadiusManager.r10),
              borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadiusManager.r10),
              borderSide: const BorderSide(color: AppColorManager.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadiusManager.r10),
              borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadiusManager.r10),
              borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadiusManager.r10),
              borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6),
            ),
          ),
          borderRadius: BorderRadius.circular(
            AppRadiusManager.r10,
          ),
          key: dropDownKey,
          isExpanded: true,
          style: TextStyle(
            fontWeight: widget.hintFontWeight ?? FontWeight.w400,
            fontFamily: FontFamilyManager.cairo,
            color: AppColorManager.textAppColor,
            fontSize: FontSizeManager.fs10,
          ),
          items: widget.options
              .map((option) => DropdownMenuItem<NameAndId>(
                    value: option,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppWidthManager.w1), // Add padding
                      child: AppTextWidget(
                        color: AppColorManager.black,
                        text: option.name,
                        fontSize: FontSizeManager.fs16,
                      ),
                    ),
                  ))
              .toList(),
          hint: AppTextWidget(
            text: widget.hint,
            fontSize: widget.hintFontSize ?? FontSizeManager.fs16,
            overflow: TextOverflow.visible,
            color: widget.hintFontColor ?? AppColorManager.hintGrey,
          ),
          onChanged: widget.readOnly
              ? null
              : (value) {
                  setState(() {
                    nameAndIdObject = value;
                  });
                  widget.onChanged!(value);
                },
        ),
      ],
    );
  }
}
