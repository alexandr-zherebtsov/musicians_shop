import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? textColor;

  const AppTextButton({
    required this.title,
    required this.onTap,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
          (states) => Get.theme.primaryColor.withOpacity(.1),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: textColor ?? Get.theme.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
