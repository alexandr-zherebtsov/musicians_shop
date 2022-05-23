import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/data/repositories/user/user_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/profile/user_profile/user_profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(() => UserProfileController());
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()), fenix: true);
  }
}
