import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? back;

  const AppBackButton({
    required this.back,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: StringsKeys.back.tr,
      icon: Icon(AppIcons.back),
      onPressed: back,
    );
  }
}
