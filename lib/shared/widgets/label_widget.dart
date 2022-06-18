import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class LabelWidget extends StatelessWidget {
  final String? label;

  const LabelWidget({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: label == null,
      child: Container(
        height: 25,
        padding: const EdgeInsets.only(
          left: 8,
          right: 6,
        ),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(AppStyles.clipRadius),
        ),
        child: Center(
          child: Text(
            label ?? '',
            style: Get.theme.textTheme.bodyText2?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
