import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class DropDownFrame extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const DropDownFrame({
    Key? key,
    required this.child,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 22,
    ),
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: margin,
      padding: padding,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Get.theme.backgroundColor,
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
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: name == null,
      child: Text(
        (name ?? '').tr,
        style: Get.theme.textTheme.bodyText1,
      ),
    );
  }
}

class DropDownHint extends StatelessWidget {
  final String hint;

  const DropDownHint({
    Key? key,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      hint.tr,
      style: Get.theme.inputDecorationTheme.hintStyle,
    );
  }
}
