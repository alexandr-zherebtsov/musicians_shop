import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isApple() ? const CupertinoActivityIndicator() : CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
      ),
    );
  }
}
