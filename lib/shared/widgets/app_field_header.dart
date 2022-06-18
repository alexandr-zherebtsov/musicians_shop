import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFieldHeader extends StatelessWidget {
  final String header;
  final EdgeInsets padding;

  const AppFieldHeader({
    Key? key,
    required this.header,
    this.padding = const EdgeInsets.only(
      top: 30,
      left: 26,
      bottom: 10,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        header.tr,
        style: Get.theme.textTheme.bodyText2,
      ),
    );
  }
}
