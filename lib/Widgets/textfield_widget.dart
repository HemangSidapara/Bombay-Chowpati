import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextFieldWidget extends StatefulWidget {
  final String? hintText;
  final int? maxLength;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isDisable;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final BoxConstraints? prefixIconConstraints;
  final Widget? prefixIcon;
  final void Function(String value)? onFieldSubmitted;
  final double? textFieldWidth;
  final bool readOnly;
  final BoxConstraints? suffixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final Color? primaryColor;
  final Color? secondaryColor;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.suffixIcon,
    this.contentPadding,
    this.isDisable = false,
    this.onChanged,
    this.onSaved,
    this.focusNode,
    this.onTap,
    this.prefixIconConstraints,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.textFieldWidth,
    this.readOnly = false,
    this.suffixIconConstraints,
    this.inputFormatters,
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.isPortrait ? null : (widget.textFieldWidth ?? 50.w),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        validator: widget.validator,
        focusNode: widget.focusNode,
        style: TextStyle(
          color: widget.secondaryColor ?? AppColors.PRIMARY_COLOR,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        obscureText: widget.obscureText ?? false,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        cursorColor: widget.secondaryColor ?? AppColors.HINT_GREY_COLOR,
        enabled: widget.isDisable == false,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        readOnly: widget.readOnly,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          counter: const SizedBox(),
          counterStyle: TextStyle(color: widget.primaryColor ?? AppColors.PRIMARY_COLOR),
          filled: true,
          prefixIconConstraints: widget.prefixIconConstraints,
          prefixIcon: widget.prefixIcon,
          fillColor: widget.primaryColor ?? AppColors.TEXTFIELD_COLOR,
          hintText: widget.hintText,
          suffixIconConstraints: widget.suffixIconConstraints,
          suffixIcon: widget.suffixIcon,
          hintStyle: TextStyle(
            color: widget.secondaryColor ?? AppColors.HINT_GREY_COLOR,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          errorStyle: TextStyle(
            color: AppColors.ERROR_COLOR,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.ERROR_COLOR,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.ERROR_COLOR,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.TRANSPARENT,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.TRANSPARENT,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.TRANSPARENT,
            ),
          ),
          errorMaxLines: 2,
          isDense: true,
          contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h).copyWith(right: 1.5.w),
        ),
      ),
    );
  }
}
