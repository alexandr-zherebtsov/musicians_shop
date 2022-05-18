import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/registration/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(() => RegistrationController());
  }
}
