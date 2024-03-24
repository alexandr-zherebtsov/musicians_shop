import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/remote/auth/auth_repository.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';
import 'package:musicians_shop/shared/values/reg_exp.dart';

class SignInController extends GetxController {
  final IAuthRepository _authRepository = Get.find<IAuthRepository>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController emailTC = TextEditingController();
  final TextEditingController passwordTC = TextEditingController();

  bool _screenLoader = false;

  bool get screenLoader => _screenLoader;

  set screenLoader(final bool value) {
    _screenLoader = value;
    update();
  }

  void done() async {
    if (validator()) {
      screenLoader = true;
      final bool res = await _authRepository.signInEmailPassword(
        email: MainUtils.clearAndTrim(emailTC.text),
        password: passwordTC.text,
      );
      screenLoader = false;
      if (_firebaseAuth.currentUser != null && res) {
        goToMain();
      } else {
        MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
      }
    } else {
      MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  bool validator() {
    return AppRegExp.emailRegExp.hasMatch(
          MainUtils.clearAndTrim(emailTC.text),
        ) &&
        passwordTC.text.length > 3;
  }

  void unFocus() => Get.focusScope?.unfocus();

  void goToMain() => Get.offAllNamed(AppRoutes.main);
}
