import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/start/start_controller.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartController>(() => StartController());
  }
}
