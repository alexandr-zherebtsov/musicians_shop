import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class HomeController extends GetxController {
  final AdvertsRepository _advertsRepository = Get.find<AdvertsRepository>();

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  late List<AdvertModel> adverts;
  List<AdvertModel> searchedAdverts = <AdvertModel>[];

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
  Future<void> onInit() async {
    super.onInit();
    screenLoader = true;
    await getAdverts();
    clearSearch();
    screenLoader = false;
  }

  Future<void> getAdverts() async {
    adverts = await _advertsRepository.getAdverts();
  }

  String searchString = '';
  bool activeSearch = false;

  final TextEditingController searchTC = TextEditingController();
  Timer? _debounceTeacherMyClassesSearch;

  void searchFunc() {
    if (searchTC.text.isEmpty) {
      clearSearch();
    } else {
      if (searchTC.text != searchString) {
        searchString = searchTC.text;
        if (_debounceTeacherMyClassesSearch?.isActive ?? false) {
          _debounceTeacherMyClassesSearch?.cancel();
        }
        _debounceTeacherMyClassesSearch = Timer(
          const Duration(milliseconds: 680),
          () {
            if (searchTC.text.isNotEmpty) {
              activeSearch = true;
              searchedAdverts.clear();
              searchAdverts();
            } else {
              clearSearch();
            }
          },
        );
      }
    }
  }

  void searchAdverts() {
    final String searchText = clearAndTrim(searchString.toLowerCase());
    for (int i = 0; i < adverts.length; i++) {
      if (clearAndTrim(adverts[i].headline).toLowerCase().contains(searchText)
          || clearAndTrim(adverts[i].description).toLowerCase().contains(searchText)
          || adverts[i].price.toString().startsWith(searchText)
      ) {
        searchedAdverts.add(adverts[i]);
      }
    }
    update();
  }

  void clearSearch() {
    searchString = '';
    activeSearch = false;
    searchTC.clear();
    searchedAdverts.clear();
    update();
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
