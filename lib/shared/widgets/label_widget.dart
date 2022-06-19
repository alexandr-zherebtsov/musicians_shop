import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class LabelWidget extends StatelessWidget {
  final String? label;
  final EdgeInsets padding;

  const LabelWidget({
    Key? key,
    required this.label,
    this.padding = const EdgeInsets.only(
      top: 4,
      left: 8,
      right: 6,
      bottom: 4,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: label == null,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(AppStyles.clipRadius),
        ),
        child: Text(
          label ?? '',
          style: Get.theme.textTheme.bodyText2?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
