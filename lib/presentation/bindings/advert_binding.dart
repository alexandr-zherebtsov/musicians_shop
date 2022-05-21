import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/advert/advert_controller.dart';

class AdvertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvertController>(() => AdvertController());
  }
}
