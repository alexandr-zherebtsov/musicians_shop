import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';

class StatisticController extends GetxController {
  final AdvertsRepository _advertsRepository = Get.find<AdvertsRepository>();

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  List<AdvertModel> myAdverts = <AdvertModel>[];

  bool _screenLoader = false;
  bool get screenLoader => _screenLoader;
  set screenLoader(bool screenLoader) {
    _screenLoader = screenLoader;
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    screenLoader = true;
    await getMyAdverts();
    screenLoader = false;
  }

  Future<void> getMyAdverts() async {
    myAdverts = await _advertsRepository.getMyAdverts(uid);
  }

  void goToAdvert(int? index) async {
    if (index != null) {
      final res = await Get.toNamed(
        AppRoutes.advert,
        arguments: myAdverts[index],
      );
      if (res == true) {
        onInit();
      }
    }
  }
}
