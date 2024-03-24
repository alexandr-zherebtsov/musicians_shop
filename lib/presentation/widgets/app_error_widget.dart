import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/widgets/app_text_button.dart';
import 'package:musicians_shop/shared/localization/keys.dart';

class AppErrorWidget extends StatelessWidget {
  final String title;
  final VoidCallback? refresh;

  const AppErrorWidget({
    this.title = StringsKeys.somethingWentWrong,
    this.refresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.tr,
                style: Get.theme.textTheme.bodyLarge,
              ),
              Offstage(
                offstage: refresh == null,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: AppTextButton(
                    title: StringsKeys.restart.tr,
                    onTap: refresh,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
