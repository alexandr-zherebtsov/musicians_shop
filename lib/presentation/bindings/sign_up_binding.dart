import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/sign_up/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
