import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/styles/themes.dart';

void showToast(String message, {bool red = false}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: kIsWeb ? ToastGravity.BOTTOM : ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: red ? Colors.red.withOpacity(0.8) : Colors.black.withOpacity(0.8),
    textColor: Colors.white,
    fontSize: 16.0,
    webBgColor: red ? '#D32F2FFF' : '#C2185BFF',
  );
}

bool isNotMobile() {
  if (kIsWeb) {
    return true;
  } else if (Platform.isAndroid || Platform.isIOS) {
    return false;
  } else {
    return true;
  }
}

ThemeData getTheme() => Get.isPlatformDarkMode ? AppThemes.dark : AppThemes.dark;

String getLangCode() {
  switch (Get.deviceLocale?.languageCode?? AppValues.langCodeBasic) {
    case AppValues.langCodeEN:
      return AppValues.langCodeEN;
    default:
      return AppValues.langCodeBasic;
  }
}

String getClearName(String? firstName, String? lastName, {comma = false}) {
  return (firstName ?? '') + (firstName == null ? '' : firstName.isEmpty ? ''
      : comma ? lastName == null ? '' : lastName.isEmpty ? '' : ', ' : ' ')
      + (lastName ?? '');
}

String clearAndTrim(String? value) {
  if (value != null) {
    return value.replaceAll(' ', '');
  } else {
    return '';
  }
}

String formatPhone(String? phoneNumber) {
  String res = '';
  if (phoneNumber != null) {
    if (phoneNumber.length > 9) {
      res = phoneNumber.substring(0, 3) +
          ' ' +
          phoneNumber.substring(3, 6) +
          ' ' +
          phoneNumber.substring(6, 8) +
          ' ' +
          phoneNumber.substring(8, 10) +
          ' ' +
          phoneNumber.substring(10, phoneNumber.length);
    }
  }
  return res;
}

Future<void> delayedFunc({int milliseconds = 1000}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
