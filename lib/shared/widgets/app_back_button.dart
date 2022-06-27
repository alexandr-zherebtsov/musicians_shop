import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';

class AppBackButton extends StatelessWidget {
  final void Function()? back;

  const AppBackButton({
    Key? key,
    required this.back
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: StringsKeys.back.tr,
      icon: Icon(AppIcons.back),
      onPressed: back,
    );
  }
}
