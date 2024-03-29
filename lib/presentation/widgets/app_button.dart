import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  const AppButton({
    required this.title,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 22,
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(.6),
              shadowColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor: MaterialStateProperty.all<Color>(
                Get.theme.primaryColor,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
                ),
              ),
            ),
            onPressed: onTap,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
