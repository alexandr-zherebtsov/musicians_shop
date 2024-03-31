import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/models/advert_model.dart';
import 'package:musicians_shop/data/models/user_model.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/remote/user/user_repository.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class HomeController extends GetxController {
  final IUserRepository _userRepository;
  final IAdvertsRepository _advertsRepository;

  HomeController(
    this._userRepository,
    this._advertsRepository,
  );

  UserModel? user;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  late List<AdvertModel> adverts;
  List<AdvertModel> searchedAdverts = <AdvertModel>[];

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
      getUser(),
      getAdverts(),
    ]);
    clearSearch();
    screenLoader = false;
  }

  Future<void> getAdverts() async {
    adverts = await _advertsRepository.getAdverts();
  }

  Stream<QuerySnapshot<Object?>> get streamAdverts =>
      _advertsRepository.streamAdverts;

  Future<void> getUser() async {
    user = await _userRepository.getUser(uid);
    if (user == null) {
      screenError = true;
    }
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
    final String searchText = MainUtils.clearAndTrim(
      searchString.toLowerCase(),
    );
    for (int i = 0; i < adverts.length; i++) {
      if (MainUtils.clearAndTrim(adverts[i].headline)
              .toLowerCase()
              .contains(searchText) ||
          MainUtils.clearAndTrim(adverts[i].description)
              .toLowerCase()
              .contains(searchText) ||
          adverts[i].price.toString().startsWith(searchText)) {
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
    sortAdverts();
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

  void likeAdvert(AdvertModel advert, {final bool isStream = false}) async {
    List<String> oldLikes = <String>[];
    oldLikes.addAll(advert.likes ?? []);
    if (advert.likes == null) {
      advert.likes = [uid];
    } else if (advert.likes!.contains(uid)) {
      advert.likes!.remove(uid);
    } else {
      advert.likes!.add(uid);
    }
    if (!isStream) {
      update();
    }
    final bool res = await _advertsRepository.editAdvert(advert);
    if (!isStream && !res) {
      advert.likes = oldLikes;
      update();
    }
  }

  void sortAdverts() {
    for (int v = 0; v < adverts.length; v++) {
      double count = 0;
      if ((user?.favoriteInstruments ?? []).isNotEmpty &&
          adverts[v].type?.id != null) {
        for (int i = 0; i < user!.favoriteInstruments!.length; i++) {
          if (user!.favoriteInstruments![i].id == adverts[v].type!.id!) {
            count += 10;
          }
        }
      }
      if ((user?.favoriteBrands ?? []).isNotEmpty &&
          adverts[v].brand?.id != null) {
        for (int i = 0; i < user!.favoriteBrands!.length; i++) {
          if (user!.favoriteBrands![i].id == adverts[v].brand!.id!) {
            count += 10;
          }
        }
      }
      if (user?.city == adverts[v].city && (user?.city ?? '').isNotEmpty) {
        count += 5;
      }
      if ((adverts[v].likes ?? []).isNotEmpty) {
        count += adverts[v].likes!.length * 0.01;
      }
      if ((adverts[v].images ?? []).isNotEmpty) {
        count += adverts[v].images!.length * 0.01;
      }
      if ((adverts[v].description ?? '').isNotEmpty) {
        if (adverts[v].description!.length >= 1000) {
          count += 1.5;
        } else {
          count += 0.5;
        }
      }
      adverts[v].userCount = count;
    }
    adverts.sort((b, a) {
      return a.userCount!.compareTo(b.userCount!);
    });
  }
}
