import 'package:flutter/material.dart';
import 'package:musicians_shop/shared/styles/icons.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class DropDownIcon extends StatelessWidget {
  const DropDownIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      AppIcons.arrowTriangleDown,
      size: MainUtils.isApple ? 12 : null,
    );
  }
}
