import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/constants/reg_exp.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class SignUpController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController emailTC = TextEditingController();
  final TextEditingController passwordTC = TextEditingController();

  bool _screenLoader = false;
  bool get screenLoader => _screenLoader;
  set screenLoader(bool screenLoader) {
    _screenLoader = screenLoader;
    update();
  }

  void done() async {
    if (validator()) {
      screenLoader = true;
      final bool res = await _authRepository.signInEmailPassword(
        email: clearAndTrim(emailTC.text),
        password: passwordTC.text,
      );
      screenLoader = false;
      if (_firebaseAuth.currentUser != null && res) {
        goToMain();
      } else {
        showToast(StringsKeys.somethingWentWrong.tr);
      }
    } else {
      showToast(StringsKeys.somethingWentWrong.tr);
    }
  }

  bool validator() {
    return AppRegExp.emailRegExp.hasMatch(clearAndTrim(emailTC.text)) && passwordTC.text.length > 3;
  }

  void unFocus() => Get.focusScope?.unfocus();
  void goToMain() => Get.offAllNamed(AppRoutes.main);
}
