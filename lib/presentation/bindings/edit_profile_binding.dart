import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/data/repositories/user/user_repository_impl.dart';
import 'package:musicians_shop/presentation/ui/profile/edit_profile/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()), fenix: true);
  }
}
