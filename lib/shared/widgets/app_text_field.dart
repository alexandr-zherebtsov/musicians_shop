import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int? maxLines;
  final String? prefix;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  const AppTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.maxLines,
    this.prefix,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 22),
    this.contentPadding = const EdgeInsets.only(left: 12),
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Get.theme.primaryColor,
        autocorrect: false,
        obscureText: obscureText,
        autofocus: false,
        inputFormatters: inputFormatters ?? [
          LengthLimitingTextInputFormatter(100),
        ],
        decoration: _textFieldStyle(
          hint: hint,
          maxLines: maxLines,
          prefix: prefix,
          suffixIcon: suffixIcon,
          contentPadding: contentPadding,
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }

  InputDecoration _textFieldStyle({
    required String hint,
    required int? maxLines,
    required String? prefix,
    required IconData? suffixIcon,
    required EdgeInsets contentPadding,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      hintMaxLines: 1,
      fillColor: Get.theme.backgroundColor,
      contentPadding: contentPadding,
      constraints: maxLines == 1 ? const BoxConstraints(
        maxHeight: 64,
      ) : null,
      prefixIcon: prefix == null ? null : Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 2,
        ),
        child: Text(
          prefix,
          style: Get.theme.textTheme.subtitle1
        ),
      ),
      prefixIconConstraints: const BoxConstraints(
        maxHeight: 225,
        minHeight: 22,
      ),
      suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
      border: _outlineInputBorder(),
      errorBorder: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      disabledBorder: _outlineInputBorder(),
      focusedErrorBorder: _outlineInputBorder(),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
      borderSide: BorderSide.none,
    );
  }
}
