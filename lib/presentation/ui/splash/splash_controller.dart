import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class SplashController extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  late String? uid;

  @override
  void onInit() async {
    super.onInit();
    uid = FirebaseAuth.instance.currentUser?.uid;
    await delayedFunc(milliseconds: 1600);
    uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      if (await checkUserData()) {
        goToMain();
      } else {
        goToUserData();
      }
    } else {
      goToStart();
    }
  }

  Future<bool> checkUserData() async {
    final UserModel? res = await _userRepository.getUser(uid!);
    return res != null;
  }

  void goToUserData() => Get.offAllNamed(AppRoutes.userData);
  void goToStart() => Get.offAllNamed(AppRoutes.start);
  void goToMain() => Get.offAllNamed(AppRoutes.main);
}
