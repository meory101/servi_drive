import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/icon_manager.dart';
import '../../resource/size_manager.dart';
import '../button/main_app_button.dart';
import '../text/app_text_widget.dart';
import 'NameAndId.dart';

///
/// created by eng nour othman
/// at 9/3/2025
///
///
class MultiSelectDropDownWidget extends StatefulWidget {
  const MultiSelectDropDownWidget({
    Key? key,
    required this.options,
    required this.hint,
    this.hintFontColor,
    this.hintFontSize,
    this.hintFontWeight,
    this.reset,
    this.validator,
    this.iconColor,
    this.width,
    this.iconSize,
    this.borderColor,
    this.isRequired,
    required this.selectedValues,
    this.onChanged,
  }) : super(key: key);

  final List<NameAndId> options;
  final String hint;
  final bool? reset;  final bool? isRequired;

  final Color? hintFontColor;
  final FontWeight? hintFontWeight;
  final double? hintFontSize;
  final List<NameAndId> selectedValues;
  final Color? borderColor;
  final double? width;
  final double? iconSize;
  final Color? iconColor;
  final String? Function(List<NameAndId>?)? validator;
  final Function(List<NameAndId>)? onChanged;

  @override
  State<MultiSelectDropDownWidget> createState() =>
      _MultiSelectDropDownWidgetState();
}

class _MultiSelectDropDownWidgetState extends State<MultiSelectDropDownWidget> {
  late List<NameAndId> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = widget.selectedValues;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showMultiSelectDialog(context),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.borderColor ?? AppColorManager.lightGreyOpacity6,
              ),
              borderRadius: BorderRadius.circular(AppRadiusManager.r10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedOptions.isEmpty
                        ? widget.hint
                        : selectedOptions.map((e) => e.name).join(', '),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: widget.hintFontWeight ?? FontWeight.w400,
                      fontSize: widget.hintFontSize ?? FontSizeManager.fs15,
                      color: widget.hintFontColor ?? AppColorManager.textGrey,
                    ),
                  ),
                ),
                SvgPicture.asset(AppIconManager.arrowMenuDown),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showMultiSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: EdgeInsets.all(AppHeightManager.h1point8),
              surfaceTintColor: AppColorManager.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: AppHeightManager.h3,
                    ),
                    ListBody(
                      children: widget.options.map((option) {
                        final isSelected = selectedOptions.contains(option);
                        return CheckboxListTile(
                          value: isSelected,
                          title: AppTextWidget(
                            text: option.name,
                            fontSize: FontSizeManager.fs15,
                            color: AppColorManager.black,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                selectedOptions.add(option);
                              } else {
                                selectedOptions.remove(option);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: AppHeightManager.h2,),
                    MainAppButton(
                      margin: EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
                      alignment: Alignment.center,
                      height: AppHeightManager.h6,
                      width: AppWidthManager.w100,
                      color: AppColorManager.mainColor,
                      onTap: () {
                        widget.onChanged!(selectedOptions);

                        Navigator.pop(context);
                      },
                      child: AppTextWidget(
                        text: "done".tr(),
                        color: AppColorManager.white,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSizeManager.fs15,
                      ),
                    ),
                    SizedBox(
                      height: AppHeightManager.h3,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
