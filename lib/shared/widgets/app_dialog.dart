import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/widgets/app_text_button.dart';

Future<dynamic> showAppDialog({
  required String title,
  required String subtitle,
  required String first,
  required String second,
}) {
  final res = Get.dialog(
    AppDialog(
      title: title,
      subtitle: subtitle,
      first: first,
      second: second,
    ),
  );
  return res;
}

class AppDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String first;
  final String second;

  const AppDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.first,
    required this.second,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
      ),
      title: Text(
        title,
        style: Get.theme.textTheme.headline3,
      ),
      content: Text(
        subtitle,
        style: Get.theme.textTheme.bodyText1,
      ),
      buttonPadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.only(left: 18),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        AppTextButton(
          title: first,
          onTap: Get.back,
        ),
        AppTextButton(
          title: second,
          onTap: () => Get.back(result: true),
        ),
      ],
    );
  }
}
