import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/user_data/user_data_controller.dart';

class UserDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDataController>(() => UserDataController());
  }
}
