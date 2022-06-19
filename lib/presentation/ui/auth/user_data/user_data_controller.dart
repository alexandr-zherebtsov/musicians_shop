import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class UserDataController extends GetxController {
  final UserRepository _userRepository;
  UserDataController(this._userRepository);

  final TextEditingController firstNameTC = TextEditingController();
  final TextEditingController lastNameTC = TextEditingController();
  final TextEditingController phoneNumberTC = TextEditingController();
  final TextEditingController cityTC = TextEditingController();

  bool _screenLoader = false;
  bool get screenLoader => _screenLoader;
  set screenLoader(bool screenLoader) {
    _screenLoader = screenLoader;
    update();
  }

  void done() async {
    if (validator()) {
      screenLoader = true;
      final UserModel? res = await _userRepository.createUser(setData());
      if (res != null) {
        goToMain();
      } else {
        showAppNotification(StringsKeys.somethingWentWrong.tr);
      }
      screenLoader = false;
    } else {
      showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  UserModel setData() {
    return UserModel(
      id: FirebaseAuth.instance.currentUser!.uid,
      email: FirebaseAuth.instance.currentUser!.email,
      firstName: firstNameTC.text.trim(),
      lastName: lastNameTC.text.trim(),
      phone: '+${phoneNumberTC.text}',
      city: cityTC.text.trim(),
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  bool validator() {
    return firstNameTC.text.isNotEmpty && lastNameTC.text.isNotEmpty &&
        phoneNumberTC.text.length > 9 && cityTC.text.isNotEmpty;
  }

  void unFocus() => Get.focusScope?.unfocus();
  void goToMain() => Get.offAllNamed(AppRoutes.main);
}
