import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/create/create_controller.dart';

class CreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateController>(() => CreateController());
  }
}
