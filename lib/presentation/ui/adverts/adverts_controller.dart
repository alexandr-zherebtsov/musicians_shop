import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/models/advert_model.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_repository.dart';
import 'package:musicians_shop/presentation/router/routes.dart';

class AdvertsController extends GetxController {
  final IAdvertsRepository _advertsRepository;

  AdvertsController(this._advertsRepository);

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  List<AdvertModel> myAdverts = <AdvertModel>[];
  List<AdvertModel> likedAdverts = <AdvertModel>[];

  bool _screenLoader = false;

  bool get screenLoader => _screenLoader;

  set screenLoader(final bool value) {
    _screenLoader = value;
    update();
  }

  bool _screenError = false;

  bool get screenError => _screenError;

  set screenError(final bool value) {
    _screenError = value;
    update();
  }

  @override
  Future<void> onInit() async {
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

  void likeAdvert({
    required AdvertModel advert,
    required bool my,
  }) async {
    List<String> oldLikes = <String>[];
    oldLikes.addAll(advert.likes ?? []);
    if (advert.likes == null) {
      advert.likes = [uid];
      if (my) {
        likedAdverts.add(advert);
      }
    } else if (advert.likes!.contains(uid)) {
      advert.likes!.remove(uid);
      if (my || advert.uid == uid) {
        likedAdverts.removeWhere((e) => advert.id == e.id);
      }
    } else {
      advert.likes!.add(uid);
      if (my) {
        likedAdverts.add(advert);
      }
    }
    update();
    final bool res = await _advertsRepository.editAdvert(advert);
    if (!res) {
      advert.likes = oldLikes;
      update();
    }
  }
}
