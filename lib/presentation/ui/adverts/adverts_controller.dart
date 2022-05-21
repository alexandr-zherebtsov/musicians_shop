import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';

class AdvertsController extends GetxController {
  final AdvertsRepository _advertsRepository = Get.find<AdvertsRepository>();

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  List<AdvertModel> myAdverts = <AdvertModel>[];
  List<AdvertModel> likedAdverts = <AdvertModel>[];

  bool _screenLoader = false;
  bool get screenLoader => _screenLoader;
  set screenLoader(bool screenLoader) {
    _screenLoader = screenLoader;
    update();
  }

  bool _screenError = false;
  bool get screenError => _screenError;
  set screenError(bool screenError) {
    _screenError = screenError;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    screenLoader = true;
    await Future.wait([
      getMyAdverts(),
      getLikedAdverts(),
    ]);
    screenLoader = false;
  }

  Future<void> getMyAdverts() async {
    myAdverts = await _advertsRepository.getMyAdverts(uid);
  }

  Future<void> getLikedAdverts() async {
    likedAdverts = await _advertsRepository.getLikedAdverts(uid);
  }

  void goToAdvert(AdvertModel advert) async {
    final res = await Get.toNamed(
      AppRoutes.advert,
      arguments: advert,
    );
    if (res == true) {
      onInit();
    }
  }

  void likeAdvert(AdvertModel advert) async {
    List<String> oldLikes = <String>[];
    oldLikes.addAll(advert.likes?? []);
    if (advert.likes == null) {
      advert.likes = [uid];
    } else if (advert.likes!.contains(uid)) {
      advert.likes!.remove(uid);
    } else {
      advert.likes!.add(uid);
    }
    update();
    final bool res = await _advertsRepository.editAdvert(advert);
    if (!res) {
      advert.likes = oldLikes;
      update();
    }
  }
}
