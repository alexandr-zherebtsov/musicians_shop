import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:musicians_shop/domain/models/brand_model.dart';
import 'package:musicians_shop/domain/models/instrument_type_model.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';

void showAppNotification(final String message) {
  toast(
    message,
    duration: const Duration(milliseconds: 1400),
  );
}

String getCurrentPlatform() => kIsWeb ? AppValues.web : AppValues.application;

String getCurrentOS() => Get.theme.platform.name;

bool isNotMobile() {
  if (kIsWeb) {
    return true;
  } else if (Platform.isAndroid || Platform.isIOS) {
    return false;
  } else {
    return true;
  }
}

bool isApple() {
 return Get.theme.platform == TargetPlatform.macOS || Get.theme.platform == TargetPlatform.iOS;
}

String getLangCode() {
  switch (Get.deviceLocale?.languageCode?? AppValues.langCodeBasic) {
    case AppValues.langCodeEN:
      return AppValues.langCodeEN;
    default:
      return AppValues.langCodeBasic;
  }
}

String getGraphDateLabel(DateTime? date) {
  if (date != null) {
    return '${getStringDate(date)}\n${getStringTime(date)}';
  } else {
    return '';
  }
}

String getStringDate(DateTime? date) {
  if (date != null) {
    try {
      return '${date.day}.${date.month}.${date.year}';
    } catch (e) {
      return '';
    }
  } else {
    return '';
  }
}

String getStringTime(DateTime? date) {
  if (date != null) {
    return '${date.hour}:${checkZeroInDate(date.minute.toString())}';
  } else {
    return '';
  }
}

String checkZeroInDate(String value) {
  if (value.length == 1) {
    return '0$value';
  } else {
    return value;
  }
}

String getClearName(String? firstName, String? lastName, {bool comma = false}) {
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

String getInstrumentTypesString(List<InstrumentTypeModel> brands) {
  String res = '';
  if (brands.isNotEmpty) {
    for (int i = 0; i < brands.length; i++) {
      if (brands[i].type != null) {
        res = '$res${brands[i].type!.tr}, ';
      }
    }
    res = replaceLast(res.trim());
  }
  return res;
}

String getBrandsString(List<BrandModel> brands) {
  String res = '';
  if (brands.isNotEmpty) {
    for (int i = 0; i < brands.length; i++) {
      if (brands[i].name != null) {
        res = '$res${brands[i].name!}, ';
      }
    }
    res = replaceLast(res.trim());
  }
  return res;
}

String formatPhone(String? phoneNumber) {
  String res = '';
  if (phoneNumber != null) {
    if (phoneNumber.length > 9) {
      res = '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6, 8)} ${phoneNumber.substring(8, 10)} ${phoneNumber.substring(10, phoneNumber.length)}';
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
      return 'image/${getFileFormatFromString(fileName)}';
    case FileTypeEnums.userPhoto:
      return 'image/${getFileFormatFromString(fileName)}';
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
    return '.${lookupMimeType(
      path,
    ).toString().split('/')[1]}';
  } catch (_) {
    return getFileFormatFromString(name);
  }
}

String priceParser(String price) {
  try {
    if (price.split('.')[1] == '0' || price.split('.')[1] == '00') {
      return price.split('.')[0];
    } else if (price.split('.')[1].length == 1) {
      return '${price}0';
    } else {
      return price;
    }
  } catch (_) {
    return price;
  }
}

String replaceLast(String? string) {
  if (string == null) {
    return '';
  } else {
    return string.substring(0, string.length - 1);
  }
}

String replaceAllSymbols(String? string) {
  if (string == null) {
    return '';
  } else {
    return string.replaceAll('+', '').replaceAll('!', '').replaceAll(')', '').replaceAll('[', '')
        .replaceAll('*', '').replaceAll('"', '').replaceAll('=', '').replaceAll('/', '').replaceAll('\\', '').replaceAll(']', '')
        .replaceAll('?', '').replaceAll('(', '').replaceAll('%', '').replaceAll('\'', '').replaceAll(':', '').replaceAll('{', '')
        .replaceAll(' ', '').replaceAll('@', '').replaceAll('\$', '').replaceAll(';', '').replaceAll('}', '')
        .replaceAll('<', '').replaceAll('>', '').replaceAll('|', '').replaceAll('.', '').replaceAll(',', '');
  }
}

Future<String> findGalleryPath() async {
  String? externalStorageDirPath;
  if (Platform.isAndroid) {
    try {
      externalStorageDirPath = await AndroidPathProvider.downloadsPath;
    } catch (e) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    }
  } else if (Platform.isIOS) {
    externalStorageDirPath = (await getApplicationDocumentsDirectory()).absolute.path;
  }
  return externalStorageDirPath!;
}

double doubleParser(dynamic data) {
  final double? doubleResult = double.tryParse(data.toString());
  return doubleResult ?? 0.0;
}

Future<void> delayedFunc({int milliseconds = 1000}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
