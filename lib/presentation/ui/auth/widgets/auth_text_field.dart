import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final EdgeInsets padding;

  const AuthTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 22),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Get.theme.primaryColor,
        autocorrect: false,
        obscureText: obscureText,
        autofocus: false,
        decoration: _textFieldStyle(
          hint: hint,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  InputDecoration _textFieldStyle({
    required String hint,
    required IconData? suffixIcon,
    EdgeInsets contentPadding = const EdgeInsets.only(left: 12)
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      hintMaxLines: 1,
      fillColor: Get.theme.backgroundColor,
      contentPadding: contentPadding,
      constraints: const BoxConstraints(
        maxHeight: 64,
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

