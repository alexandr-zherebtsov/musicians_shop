import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class EditProfileController extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();

  final TextEditingController firstNameTC = TextEditingController();
  final TextEditingController lastNameTC = TextEditingController();
  final TextEditingController cityTC = TextEditingController();
  final TextEditingController emailTC = TextEditingController();
  final TextEditingController phoneNumberTC = TextEditingController();
  final TextEditingController aboutYourselfTC = TextEditingController();

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
  void onInit() {
    super.onInit();
    setDataToScreen();
  }

  void setDataToScreen() {
    try {
      final UserModel user = Get.arguments as UserModel;
      firstNameTC.text = user.firstName ?? '';
      lastNameTC.text = user.lastName ?? '';
      phoneNumberTC.text = (user.phone ?? '').replaceAll('+', '');
      cityTC.text = user.city ?? '';
      aboutYourselfTC.text = user.aboutYourself ?? '';
    } catch (e) {
      log(e.toString());
    }
  }

  void save() async {
    if (validator()) {
      final bool res = await _userRepository.editUserData(setUserData());
      if (res) {
        showAppNotification(StringsKeys.done.tr);
        Get.back(result: true);
      } else {
        showAppNotification(StringsKeys.somethingWentWrong.tr);
      }
    } else {
      showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  UserModel setUserData() {
    UserModel user = Get.arguments as UserModel;
    user.firstName = firstNameTC.text.trim();
    user.lastName = lastNameTC.text.trim();
    user.phone = '+${phoneNumberTC.text}';
    user.city = cityTC.text.trim();
    user.aboutYourself = aboutYourselfTC.text.trim();
    user.updatedAt = Timestamp.now();
    return user;
  }

  bool validator() {
    return firstNameTC.text.isNotEmpty && lastNameTC.text.isNotEmpty &&
        phoneNumberTC.text.length > 9 && cityTC.text.isNotEmpty;
  }

  void unFocus() => Get.focusScope?.unfocus();
}
