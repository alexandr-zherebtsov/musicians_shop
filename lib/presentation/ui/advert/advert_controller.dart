import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';

class AdvertController extends GetxController {
  final AdvertsRepository _advertsRepository = Get.find<AdvertsRepository>();

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

  int _selectedImage = 0;
  int get selectedImage => _selectedImage;
  set selectedImage(int selectedImage) {
    _selectedImage = selectedImage;
    update();
  }

  bool? refreshResult;
  late AdvertModel advert;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    try {
      advert = Get.arguments as AdvertModel;
    } catch (e) {
      screenError = true;
      log(e.toString());
    }
  }

  void onTapLike() async {
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
    } else {
      refreshResult = true;
    }
  }

  Future<bool> willPopScope() async {
    Get.back(result: refreshResult);
    return true;
  }
}
