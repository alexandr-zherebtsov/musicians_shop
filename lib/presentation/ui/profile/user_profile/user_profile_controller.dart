import 'dart:developer';

import 'package:get/get.dart';
import 'package:musicians_shop/data/models/user_model.dart';
import 'package:musicians_shop/data/remote/user/user_repository.dart';

class UserProfileController extends GetxController {
  final IUserRepository _userRepository;

  UserProfileController(this._userRepository);

  UserModel? user;

  bool _screenLoader = false;

  bool get screenLoader => _screenLoader;

  set screenLoader(final bool value) {
    _screenLoader = value;
    update();
  }

  bool _screenError = false;

  bool get screenError => _screenError;

  set screenError(final bool value) {
    _screenError = value;
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
