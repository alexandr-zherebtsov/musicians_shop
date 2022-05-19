import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository.dart';
import 'package:musicians_shop/data/repositories/auth/auth_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/auth/sign_up/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()), fenix: true);
  }
}
