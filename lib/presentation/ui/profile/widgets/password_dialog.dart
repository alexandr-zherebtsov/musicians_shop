import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:musicians_shop/shared/widgets/app_text_button.dart';
import 'package:musicians_shop/shared/widgets/app_text_field.dart';

class PasswordAlertDialog extends StatelessWidget {
  final TextEditingController passwordTC;
  final RxBool loader;
  final void Function() confirmFunc;

  const PasswordAlertDialog({
    Key? key,
    required this.passwordTC,
    required this.loader,
    required this.confirmFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
      ),
      title: Text(
        StringsKeys.deleteAccount.tr + '?',
        style: Get.theme.textTheme.headline3,
      ),
      contentPadding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              StringsKeys.confirmYourPassword.tr,
              style: Get.theme.textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 80,
            child: Center(
              child: Obx(() => loader.value ? const AppProgress() : AppTextField(
                controller: passwordTC,
                hint: StringsKeys.password.tr,
                maxLines: 1,
                obscureText: true,
                suffixIcon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                padding: EdgeInsets.zero,
                onSubmitted: (_) => confirmFunc(),
              )),
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: const EdgeInsets.only(
        bottom: 10,
      ),
      actions: [
        AppTextButton(
          title: StringsKeys.cancel.tr,
          onTap: () {
            passwordTC.clear();
            Get.back();
          },
        ),
        AppTextButton(
          title: StringsKeys.continueText.tr,
          onTap: confirmFunc,
        ),
      ],
    );
  }
}
