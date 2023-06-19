import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:musicians_shop/data/remote/push_notification_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/presentation/ui/adverts/adverts_controller.dart';
import 'package:musicians_shop/presentation/ui/home/home_controller.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';

class MainController extends GetxController {
  final PushNotificationRepository _pushNotificationRepository;

  MainController(this._pushNotificationRepository);

  @override
  Future<void> onInit() async {
    super.onInit();
    await _pushNotificationRepository.initializePN();
  }

  MainScreenEnums _screenType = MainScreenEnums.home;
  MainScreenEnums get screenType => _screenType;
  set screenType(final MainScreenEnums screenType) {
    _screenType = screenType;
    update();
  }

  void onNavTap(final MainScreenEnums type) {
    if (type == MainScreenEnums.create) {
      goToCreate();
    } else {
      screenType = type;
    }
  }

  Future<void> goToCreate() async {
    try {
      final res = await Get.toNamed(AppRoutes.create);
      if (res != null) {
        switch (screenType) {
          case MainScreenEnums.home:
            final HomeController hc = Get.find<HomeController>();
            hc.adverts.add(res as AdvertModel);
            hc.update();
            break;
          case MainScreenEnums.adverts:
            final AdvertsController ac = Get.find<AdvertsController>();
            ac.myAdverts.add(res as AdvertModel);
            ac.update();
            break;
          default:
            break;
        }
      }
    } catch (_) {}
  }

  void goToAbout() => Get.toNamed(AppRoutes.about);

  void unFocus() => Get.focusScope?.unfocus();

  Future<bool> willPopScope() async {
    final bool res = screenType == MainScreenEnums.home;
    res ? Get.back() : screenType = MainScreenEnums.home;
    return kIsWeb ? false : res;
  }
}
