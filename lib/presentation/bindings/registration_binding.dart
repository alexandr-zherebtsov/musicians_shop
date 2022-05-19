import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/auth/registration/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(() => RegistrationController());
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()), fenix: true);
  }
}
