import 'package:get/get.dart';
import 'package:musicians_shop/presentation/router/routes.dart';

class StartController extends GetxController {
  void goToSignUp() => Get.toNamed(AppRoutes.signUp);
  void goToRegistration() => Get.toNamed(AppRoutes.registration);
}
