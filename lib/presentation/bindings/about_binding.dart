import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/about/about_controller.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AboutController>(AboutController());
  }
}
