import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
      ),
    );
  }
}
