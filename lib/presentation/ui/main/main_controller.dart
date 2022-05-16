import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';

class MainController extends GetxController {
  MainScreenEnums _screenType = MainScreenEnums.home;
  MainScreenEnums get screenType => _screenType;
  set screenType(MainScreenEnums screenType) {
    _screenType = screenType;
    update();
  }

  void onNavTap(MainScreenEnums type) {
    if (type == MainScreenEnums.create) {
      goToCreate();
    } else {
      screenType = type;
    }
  }

  void goToCreate() => Get.toNamed(AppRoutes.create);
  void goToAbout() => Get.toNamed(AppRoutes.about);

  Future<bool> willPopScope() async {
    final bool res = screenType == MainScreenEnums.home;
    res ? Get.back() : screenType = MainScreenEnums.home;
    return kIsWeb ? false : res;
  }
}
