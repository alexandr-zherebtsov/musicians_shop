import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class DropDownFrame extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const DropDownFrame({
    required this.child,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 22,
    ),
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12,
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: margin,
      padding: padding,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class DropDownItem extends StatelessWidget {
  final String? name;

  const DropDownItem({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: name == null,
      child: Text(
        (name ?? '').tr,
        style: Get.theme.textTheme.bodyLarge,
      ),
    );
  }
}

class DropDownHint extends StatelessWidget {
  final String hint;

  const DropDownHint({
    required this.hint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      hint.tr,
      style: Get.theme.inputDecorationTheme.hintStyle,
    );
  }
}
