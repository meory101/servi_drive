import 'package:servi_drive/core/resource/color_manager.dart';
import 'package:flutter/material.dart';

import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';
import '../text/app_text_widget.dart';
import '../text/required_text_widget.dart';
import 'app_form_field.dart';

class TitleAppFormFiled extends StatefulWidget {
  const TitleAppFormFiled({
    super.key,
    required this.hint,
    required this.title,
    required this.onChanged,
    required this.validator,
    this.initValue,
    this.style,
    this.onTap,
    this.suffixIcon,
    this.onIconTaped,
    this.maxLines,
    this.minLines,
    this.isRequired,
    this.readOnly,
    this.multiLines,
    this.textInputType,
    this.hintTextDirection,
    this.controller,
    this.tileActionWidget,
    this.textDirection,
    this.obscureText,
    this.formKey,
  });

  final String title, hint;
  final String? Function(String?) onChanged;
  final String? Function(String?) validator;
  final String? initValue;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool? readOnly;
  final bool? multiLines;
  final bool? obscureText;
  final TextStyle? style;
  final Function()? onIconTaped;
  final bool? isRequired;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? controller;
  final GlobalKey<FormState>? formKey;
  final TextInputType? textInputType;
  final TextDirection? hintTextDirection;
  final TextDirection? textDirection;
  final Widget? tileActionWidget;

  @override
  State<TitleAppFormFiled> createState() => _TitleAppFormFiledState();
}

class _TitleAppFormFiledState extends State<TitleAppFormFiled> {
  final FocusNode _focusNode = FocusNode();
  bool? _isDoneTyping;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isDoneTyping = !_focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleColor = _isDoneTyping == null
        ? AppColorManager.black
        : _isDoneTyping ?? true
            ? Colors.black
            : Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isRequired == true
              ? RequiredTextWidget(
            title: widget.title,
            color: titleColor,
          )
              : AppTextWidget(
            text: widget.title,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),


          widget.tileActionWidget??Center()
        ],
      ),
        SizedBox(height: AppHeightManager.h08),
        AppTextFormField(
          focusNode: _focusNode,
          onTap: widget.onTap,
          hintTextDirection: widget.hintTextDirection,
          controller: widget.controller,
          style: widget.style,
          readOnly: widget.readOnly,
          suffixIcon: widget.suffixIcon,
          initialValue: widget.initValue,
          minLines: widget.multiLines == true ? widget.minLines ?? 5 : 1,
          maxLines: widget.maxLines,
          obscureText: widget.obscureText,
          validator: widget.validator,
          onChanged: widget.onChanged,
          textInputAction: TextInputAction.done,
          hintText: widget.hint,
          textInputType: widget.textInputType,
          textDirection: widget.textDirection,
        ),
      ],
    );
  }
}
