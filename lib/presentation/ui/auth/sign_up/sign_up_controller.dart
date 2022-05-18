import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class SignUpController extends GetxController {
  final TextEditingController emailTC = TextEditingController();
  final TextEditingController passwordTC = TextEditingController();

  bool _screenLoader = false;
  bool get screenLoader => _screenLoader;
  set screenLoader(bool screenLoader) {
    _screenLoader = screenLoader;
    update();
  }

  void done() async {
    screenLoader = true;
    await delayedFunc();
    goToMain();
    screenLoader = false;
  }

  void unFocus() => Get.focusScope?.unfocus();
  void goToMain() => Get.offAllNamed(AppRoutes.main);
}
