import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/widgets/app_text_button.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

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
    super.key,
    required this.title,
    required this.subtitle,
    required this.first,
    required this.second,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      buttonPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
      ),
      title: Text(
        title,
        style: Get.theme.textTheme.headlineMedium,
      ),
      content: Text(
        subtitle,
        style: Get.theme.textTheme.bodyLarge,
      ),
      actionsPadding: const EdgeInsets.only(
        bottom: 18,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
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
