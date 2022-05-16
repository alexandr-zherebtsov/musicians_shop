import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/styles/themes.dart';

bool isNotMobile() {
  if (kIsWeb) {
    return true;
  } else if (Platform.isAndroid || Platform.isIOS) {
    return false;
  } else {
    return true;
  }
}

ThemeData getTheme() => Get.isPlatformDarkMode ? AppThemes.dark : AppThemes.light;

String getLangCode() {
  switch (Get.deviceLocale?.languageCode?? AppValues.langCodeBasic) {
    case AppValues.langCodeEN:
      return AppValues.langCodeEN;
    default:
      return AppValues.langCodeBasic;
  }
}

Future<void> delayedFunc({int milliseconds = 1000}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
