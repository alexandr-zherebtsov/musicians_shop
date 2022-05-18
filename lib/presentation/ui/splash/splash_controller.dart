import 'package:get/get.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class SplashController extends GetxController {
  final String title = StringsKeys.musicianShop.tr;

  @override
  void onInit() async {
    super.onInit();
    await delayedFunc(milliseconds: 1600);
    goToStart();
  }

  void goToStart() => Get.offAllNamed(AppRoutes.start);
  void goToMain() => Get.offAllNamed(AppRoutes.main);
}
