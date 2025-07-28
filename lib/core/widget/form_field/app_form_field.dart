import 'package:flutter/material.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';

class AppTextFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? enabled;
  final String? Function(String?)? validator;
  final String? Function(String?)? onFilledSubmited;
  final Function()? editingComplete;
  final String? Function(String?)? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final FocusNode? focusNode;
  final String? labelText;
  final String? initialValue;
  final TextAlignVertical? textAlignVertical;
  final Color? textColor;
  final Color? labelColor;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool? outlinedBorder;
  final bool? expand;
  final bool? autoFoucs;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final bool? readOnly;
  final TextStyle? style;
  final void Function()? onTap;
  final TextDirection? hintTextDirection;
  final TextDirection? textDirection;

  final bool? isRequired;

  final double? height;

  const AppTextFormField({
    Key? key,
    this.borderRadius,
    this.minLines,
    this.isRequired,
    this.filled,
    this.hintTextDirection,
    this.readOnly,
    this.enabled,
    this.suffixIcon,
    this.fillColor,
    this.expand,
    this.contentPadding,
    this.controller,
    this.obscureText,
    this.autoFoucs,
    this.onTap,
    this.validator,
    this.hintStyle,
    this.editingComplete,
    this.onChanged,
    this.textInputType,
    this.textInputAction,
    this.textAlignVertical,
    this.focusNode,
    this.labelText,
    this.style,
    this.textColor = AppColorManager.textAppColor,
    this.labelColor,
    this.onFilledSubmited,
    this.initialValue,
    this.maxLines,
    this.prefixIcon,
    this.hintText,
    this.outlinedBorder,
    this.height,
    this.textDirection
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        textDirection: textDirection,
        onTap: onTap,
        key: Key(initialValue ?? ""),
        readOnly: readOnly ?? false,
        textAlignVertical: textAlignVertical,
        onFieldSubmitted: onFilledSubmited,
        cursorColor: AppColorManager.mainColor,
        validator: validator,
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        autofocus: autoFoucs ?? false,
        onEditingComplete: editingComplete,
        keyboardType: textInputType,
        textInputAction: textInputAction ?? TextInputAction.done,
        minLines: minLines,
        maxLines: maxLines,
        initialValue: initialValue,
        enabled: enabled,
        expands: expand ?? false,

        obscuringCharacter: '*',
        decoration: InputDecoration(
          filled: filled ?? true,
          fillColor: fillColor ?? AppColorManager.mainGreyColor,
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintTextDirection:hintTextDirection ,
          hintStyle: hintStyle ??
              TextStyle(
                color: AppColorManager.hintGrey,
                fontSize: FontSizeManager.fs15,
              ),
          prefixIconColor: Colors.grey,
          suffixIconColor: Colors.grey,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                horizontal: AppWidthManager.w3,
                vertical: (height ?? AppHeightManager.h1) / 4,
              ),
          labelText: labelText,
          labelStyle: TextStyle(
              color: labelColor,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.bold,
              fontFamily: FontFamilyManager.cairo),
          errorStyle: TextStyle(
            fontSize: FontSizeManager.fs14,
            fontFamily: FontFamilyManager.cairo,
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  borderRadius != null ? borderRadius! : AppRadiusManager.r10)),
              borderSide: const BorderSide(
                color: AppColorManager.red,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  borderRadius != null ? borderRadius! : AppRadiusManager.r10)),
              borderSide: BorderSide(
                color: AppColorManager.lightGreyOpacity6,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  borderRadius != null ? borderRadius! : AppRadiusManager.r10)),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  borderRadius != null ? borderRadius! : AppRadiusManager.r10)),
              borderSide: const BorderSide(
                color: AppColorManager.grey,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  borderRadius != null ? borderRadius! : AppRadiusManager.r10)),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              )),
        ),

        style: style ??
            TextStyle(
                color: textColor,
                fontSize: FontSizeManager.fs16,
                fontFamily: FontFamilyManager.cairo),
      ),
    );
  }
}
