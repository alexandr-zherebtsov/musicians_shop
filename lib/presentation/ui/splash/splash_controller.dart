import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class SplashController extends GetxController {
  final UserRepository _userRepository;
  SplashController(this._userRepository);

  String? _uid;

  @override
  void onInit() async {
    super.onInit();
    await delayedFunc(milliseconds: 1600);
    if (await checkFirebaseUser()) {
      if (await checkUserData()) {
        goToMain();
      } else {
        goToUserData();
      }
    } else {
      goToStart();
    }
  }

  Future<bool> checkFirebaseUser() async {
    User? res;
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      res = await _userRepository.getFirebaseUser();
      _uid = res?.uid;
    }
    return res != null;
  }

  Future<bool> checkUserData() async {
    UserModel? res;
    if (_uid != null) {
      res = await _userRepository.getUser(_uid!);
    }
    return res != null;
  }

  void goToUserData() => Get.offAllNamed(AppRoutes.userData);
  void goToStart() => Get.offAllNamed(AppRoutes.start);
  void goToMain() => Get.offAllNamed(AppRoutes.main);
}
