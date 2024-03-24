import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/splash/splash_controller.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/values/app_values.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.scaffoldBackgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
              tag: AppValues.heroMusicNoteOutlined,
              child: Icon(
                AppIcons.musicNote,
                color: Get.theme.primaryColor,
                size: 160,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 60,
              ),
              child: Text(
                StringsKeys.musiciansShop.tr,
                style: Get.theme.textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppStyles.clipRadius),
              child: SizedBox(
                width: 220,
                child: LinearProgressIndicator(
                  color: Get.theme.primaryColor,
                  minHeight: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
