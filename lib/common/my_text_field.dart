import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class MyTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final FormFieldValidator<String>? validatorFunction;
  final ValueChanged<String?>? onSave;
  final EdgeInsets? padding;
  final TextInputType? inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? prefixBoxConstraint;
  final BoxConstraints? suffixBoxConstraint;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enable;
  final Color? fillColor;
  final EdgeInsets? margin;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? errorText;
  final bool? passwordField;

  const MyTextField({
    super.key,
    this.label,
    this.hint,
    this.validatorFunction,
    this.onSave,
    this.padding,
    this.inputType,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixBoxConstraint,
    this.suffixBoxConstraint,
    this.controller,
    this.onTap,
    this.readOnly,
    this.inputFormatters,
    this.enable = false,
    this.fillColor,
    this.margin,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.focusNode,
    this.errorText,
    this.passwordField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorConst.neutralShade60,
            ),
          ),
          const Gap(6),
        ],
        TextFormField(
          onTap: onTap,
          maxLines: maxLines ?? 1,
          readOnly: readOnly ?? false,
          focusNode: focusNode,
          controller: controller,
          cursorColor: ColorConst.primary,
          keyboardType: inputType,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          style: TextStyles.body2.copyWith(color: ColorConst.neutralShade90),
          maxLength: maxLength,
          obscureText: passwordField ?? false,
          validator: validatorFunction,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyles.body2.copyWith(
              color: ColorConst.neutralShade40,
            ),
            filled: fillColor != null,
            fillColor: fillColor,
            counterText: "",
            errorMaxLines: 2,
            isCollapsed: true,
            contentPadding: padding,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            suffixIconConstraints: suffixBoxConstraint,
            prefixIconConstraints: prefixBoxConstraint,
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
