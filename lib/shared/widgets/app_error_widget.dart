import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            StringsKeys.somethingWentWrong.tr,
          ),
        ),
      ),
    );
  }
}
