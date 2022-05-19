import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/widgets/app_text_button.dart';

class AppErrorWidget extends StatelessWidget {
  final void Function()? refresh;

  const AppErrorWidget({
    Key? key,
    this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringsKeys.somethingWentWrong.tr,
                style: Get.theme.textTheme.bodyText1,
              ),
              Offstage(
                offstage: refresh == null,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
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
