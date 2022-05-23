import 'dart:developer';

import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/domain/models/user_model.dart';

class UserProfileController extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();

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
  Future<void> onInit() async {
    super.onInit();
    screenLoader = true;
    await getUser();
    screenLoader = false;
  }

  Future<void> getUser() async {
    try {
      final String uid = Get.arguments as String;
      user = await _userRepository.getUser(uid);
      if (user == null) {
        screenError = true;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
