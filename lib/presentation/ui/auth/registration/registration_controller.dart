import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/constants/reg_exp.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class RegistrationController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  final TextEditingController emailTC = TextEditingController();
  final TextEditingController passwordTC = TextEditingController();
  final TextEditingController repeatPasswordTC = TextEditingController();

  bool _screenLoader = false;
  bool get screenLoader => _screenLoader;
  set screenLoader(bool screenLoader) {
    _screenLoader = screenLoader;
    update();
  }

  void done() async {
    if (validator()) {
      screenLoader = true;
      final User? res = await _authRepository.registerEmailPassword(
        email: emailTC.text,
        password: passwordTC.text,
      );
      screenLoader = false;
      if (res != null) {
        goToUserData();
      } else {
        showAppNotification(StringsKeys.somethingWentWrong.tr);
      }
    } else {
      showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  bool validator() {
    return AppRegExp.emailRegExp.hasMatch(clearAndTrim(emailTC.text))
        && passwordTC.text.length > 3 && passwordTC.text == repeatPasswordTC.text;
  }

  void unFocus() => Get.focusScope?.unfocus();
  void goToUserData() => Get.offAllNamed(AppRoutes.userData);
}
