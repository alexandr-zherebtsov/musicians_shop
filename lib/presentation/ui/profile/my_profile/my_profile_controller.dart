import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/presentation/ui/profile/widgets/password_dialog.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class MyProfileController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final UserRepository _userRepository = Get.find<UserRepository>();

  final TextEditingController passwordTC = TextEditingController();
  RxBool passwordLoader = false.obs;

  UserModel? user;

  bool _screenLoader = false;
  bool get screenLoader => _screenLoader;
  set screenLoader(bool screenLoader) {
    _screenLoader = screenLoader;
    update();
  }

  bool _screenError = false;
  bool get screenError => _screenError;
  set screenError(bool screenError) {
    _screenError = screenError;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    screenLoader = true;
    await getUser();
    screenLoader = false;
  }

  Future<void> getUser() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      user = await _userRepository.getUser(uid);
      if (user == null) {
        screenError = true;
      }
    } else {
      screenError = true;
    }
  }

  void onTapIcon() {

  }

  void onTapEdit() {

  }

  void onTapDeleteAccount() {
    Get.dialog(
      PasswordAlertDialog(
        loader: passwordLoader,
        passwordTC: passwordTC,
        confirmFunc: deleteUser,
      ),
    );
  }

  void deleteUser() async {
    if (passwordTC.text.length > 3) {
      passwordLoader(true);
      final bool auth = await _authRepository.signInEmailPassword(
        email: user!.email!,
        password: passwordTC.text,
      );
      passwordLoader(false);
      screenLoader = true;
      if (auth) {
        Get.back();
        await Future.wait([
          _userRepository.deleteUserData(user!.id!),
          _authRepository.deleteUser(),
        ]);
        showToast(StringsKeys.done.tr);
        logOut();
      } else {
        showToast(StringsKeys.somethingWentWrong.tr);
      }
      screenLoader = false;
    } else {
      showToast(StringsKeys.somethingWentWrong.tr);
    }
  }

  void logOut() async {
    await _authRepository.logOut();
    Get.offAllNamed(AppRoutes.start);
  }
}
