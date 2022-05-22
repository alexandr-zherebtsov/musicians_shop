import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
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

ThemeData getTheme() => Get.isPlatformDarkMode ? AppThemes.dark : AppThemes.light;

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

String getFileUrl(FileTypeEnums type) {
  return getFileFolder(type) + generateId(getFileTag(type));
}

String generateId(String tag) {
  return tag + (1000 + math.Random().nextInt(100)).toString() + DateTime.now().toString().replaceAll(' ', '').replaceAll('+', '')
      .replaceAll('-', '').replaceAll(':', '').replaceAll(',', '').replaceAll('.', '')
      + (1000000000 + math.Random().nextInt(10000000)).toString();
}

String getFileTag(FileTypeEnums type) {
  switch (type) {
    case FileTypeEnums.advertPhoto:
      return 'AP';
    case FileTypeEnums.userPhoto:
      return 'UP';
    default:
      return '';
  }
}

String getFileFolder(FileTypeEnums type) {
  switch (type) {
    case FileTypeEnums.advertPhoto:
      return 'adverts/';
    case FileTypeEnums.userPhoto:
      return 'users/';
    default:
      return '';
  }
}

String getFileType({
  required String fileName,
  required FileTypeEnums type,
}) {
  switch (type) {
    case FileTypeEnums.advertPhoto:
      return 'image/' + getFileFormatFromString(fileName);
    case FileTypeEnums.userPhoto:
      return 'image/' + getFileFormatFromString(fileName);
    default:
      return '';
  }
}

String getFileFormatFromString(
  String filename, {
  bool dot = false,
}) {
  try {
    return (dot ? '.' : '') + filename.split('.').last;
  } catch (_) {
    return '';
  }
}

String getFileFormatFromFile({
  required String path,
  required String name,
  bool dot = false,
}) {
  try {
    return '.' + lookupMimeType(
      path,
    ).toString().split('/')[1];
  } catch (_) {
    return getFileFormatFromString(name);
  }
}

String priceParser(String price) {
  try {
    if (price.split('.')[1] == '0' || price.split('.')[1] == '00') {
      return price.split('.')[0];
    } else if (price.split('.')[1].length == 1) {
      return price + '0';
    } else {
      return price;
    }
  } catch (_) {
    return price;
  }
}

double doubleParser(dynamic data) {
  final double? doubleResult = double.tryParse(data.toString());
  return doubleResult ?? 0.0;
}

Future<void> delayedFunc({int milliseconds = 1000}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
