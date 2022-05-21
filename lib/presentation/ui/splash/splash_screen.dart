import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/splash/splash_controller.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

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
                Icons.music_note_outlined,
                color: Get.theme.primaryColor,
                size: 160,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
                bottom: 60.0,
              ),
              child: Text(
                StringsKeys.musicianShop.tr,
                style: Get.theme.textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppStyles.clipRadius),
              child: const SizedBox(
                width: 220,
                child: LinearProgressIndicator(
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
