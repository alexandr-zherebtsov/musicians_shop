import 'dart:developer';

import 'package:get/get.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutController extends GetxController {
  RxString version = ''.obs;
  late PackageInfo packageInfo;

  @override
  void onInit() async {
    super.onInit();
    getVersion();
  }

  void getVersion() async {
    try {
      packageInfo = await PackageInfo.fromPlatform();
      version('${StringsKeys.version.tr} ${packageInfo.version}');
    } catch (e) {
      log(e.toString());
    }
  }

  void launchTo(String url) async {
    try {
      await launchUrl(_getUri(url)!);
    } catch (e) {
      log('Could not launch $url');
      log(e.toString());
    }
  }

  static Uri? _getUri(String url) {
    return Uri.tryParse(url.trimLeft());
  }
}
