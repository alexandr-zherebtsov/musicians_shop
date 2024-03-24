import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:musicians_shop/data/models/brand_model.dart';
import 'package:musicians_shop/data/models/file_to_upload.dart';
import 'package:musicians_shop/data/models/instrument_type_model.dart';
import 'package:musicians_shop/shared/values/app_values.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';

class MainUtils {
  static void showAppNotification(final String message) {
    toast(
      message,
      duration: const Duration(milliseconds: 1400),
    );
  }

  static String get getCurrentPlatform =>
      kIsWeb ? AppValues.web : AppValues.application;

  static String get getCurrentOS => Get.theme.platform.name;

  static bool get isWebMobile =>
      kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  static bool get isWebAndroid =>
      kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static bool get isWebIos =>
      kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  static bool get isApple =>
      Get.theme.platform == TargetPlatform.macOS ||
      Get.theme.platform == TargetPlatform.iOS;

  static bool get isMobileApp => !isNotMobileApp;

  static bool get isNotMobileApp {
    if (kIsWeb) {
      return true;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return false;
    } else {
      return true;
    }
  }

  static String get getLangCode {
    switch (Get.deviceLocale?.languageCode ?? AppValues.langCodeBasic) {
      case AppValues.langCodeEN:
        return AppValues.langCodeEN;
      default:
        return AppValues.langCodeBasic;
    }
  }

  static String getGraphDateLabel(final DateTime? date) {
    if (date != null) {
      return '${getStringDate(date)}\n${getStringTime(date)}';
    } else {
      return '';
    }
  }

  static String getStringDate(final DateTime? date) {
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

  static String getStringTime(final DateTime? date) {
    if (date != null) {
      return '${date.hour}:${checkZeroInDate(date.minute.toString())}';
    } else {
      return '';
    }
  }

  static String checkZeroInDate(final String value) {
    if (value.length == 1) {
      return '0$value';
    } else {
      return value;
    }
  }

  static String getClearName(
    final String? firstName,
    final String? lastName, {
    final bool comma = false,
  }) {
    return (firstName ?? '') +
        (firstName == null
            ? ''
            : firstName.isEmpty
                ? ''
                : comma
                    ? lastName == null
                        ? ''
                        : lastName.isEmpty
                            ? ''
                            : ', '
                    : ' ') +
        (lastName ?? '');
  }

  static String clearAndTrim(final String? value) {
    if (value != null) {
      return value.replaceAll(' ', '');
    } else {
      return '';
    }
  }

  static String getInstrumentTypesString(
      final List<InstrumentTypeModel> brands) {
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

  static String getBrandsString(final List<BrandModel> brands) {
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

  static String formatPhone(final String? phoneNumber) {
    String res = '';
    if (phoneNumber != null) {
      if (phoneNumber.length > 9) {
        res =
            '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6, 8)} ${phoneNumber.substring(8, 10)} ${phoneNumber.substring(10, phoneNumber.length)}';
      }
    }
    return res;
  }

  static String getFileUrl(final FileTypeEnums type) {
    return getFileFolder(type) + generateId(getFileTag(type));
  }

  static String generateId(final String tag) {
    return tag +
        (1000 + math.Random().nextInt(100)).toString() +
        DateTime.now()
            .toString()
            .replaceAll(' ', '')
            .replaceAll('+', '')
            .replaceAll('-', '')
            .replaceAll(':', '')
            .replaceAll(',', '')
            .replaceAll('.', '') +
        (1000000000 + math.Random().nextInt(10000000)).toString();
  }

  static String getFileTag(final FileTypeEnums type) {
    switch (type) {
      case FileTypeEnums.advertPhoto:
        return 'AP';
      case FileTypeEnums.userPhoto:
        return 'UP';
      default:
        return '';
    }
  }

  static String getFileFolder(final FileTypeEnums type) {
    switch (type) {
      case FileTypeEnums.advertPhoto:
        return 'adverts/';
      case FileTypeEnums.userPhoto:
        return 'users/';
      default:
        return '';
    }
  }

  static String getFileType({
    required final String fileName,
    required final FileTypeEnums type,
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

  static String getFileFormatFromString(
    final String filename, {
    final bool dot = false,
  }) {
    try {
      return (dot ? '.' : '') + filename.split('.').last;
    } catch (_) {
      return '';
    }
  }

  static String getFileFormatFromFile({
    required final String path,
    required final String name,
    final bool dot = false,
  }) {
    try {
      return '.${lookupMimeType(
        path,
      ).toString().split('/')[1]}';
    } catch (_) {
      return getFileFormatFromString(name);
    }
  }

  static String priceParser(final String price) {
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

  static String replaceLast(final String? string) {
    if (string == null) {
      return '';
    } else {
      return string.substring(0, string.length - 1);
    }
  }

  static String replaceAllSymbols(final String? string) {
    if (string == null) {
      return '';
    } else {
      return string
          .replaceAll('+', '')
          .replaceAll('!', '')
          .replaceAll(')', '')
          .replaceAll('[', '')
          .replaceAll('*', '')
          .replaceAll('"', '')
          .replaceAll('=', '')
          .replaceAll('/', '')
          .replaceAll('\\', '')
          .replaceAll(']', '')
          .replaceAll('?', '')
          .replaceAll('(', '')
          .replaceAll('%', '')
          .replaceAll('\'', '')
          .replaceAll(':', '')
          .replaceAll('{', '')
          .replaceAll(' ', '')
          .replaceAll('@', '')
          .replaceAll('\$', '')
          .replaceAll(';', '')
          .replaceAll('}', '')
          .replaceAll('<', '')
          .replaceAll('>', '')
          .replaceAll('|', '')
          .replaceAll('.', '')
          .replaceAll(',', '');
    }
  }

  static Future<String> findGalleryPath() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath!;
  }

  static double doubleParser(final dynamic data) {
    final double? doubleResult = double.tryParse(data.toString());
    return doubleResult ?? 0;
  }

  static Future<void> delayedFunc({final int milliseconds = 1000}) async =>
      await Future<void>.delayed(Duration(milliseconds: milliseconds));
}
