import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/models/advert_model.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/remote/push_notification/push_notification_repository.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/presentation/ui/adverts/adverts_controller.dart';
import 'package:musicians_shop/presentation/ui/home/home_controller.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/shared/values/app_values.dart';

class MainController extends GetxController {
  final IAdvertsRepository _advertsRepository;
  final IPushNotificationRepository _pushNotificationRepository;

  MainController(
    this._advertsRepository,
    this._pushNotificationRepository,
  );

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.wait([
      _setUpAudio(),
      _pushNotificationRepository.initializePN(),
    ]);
  }

  final AssetsAudioPlayer _audio = AssetsAudioPlayer();

  Future<void> _setUpAudio() async {
    try {
      await _audio.open(
        kIsWeb
            ? Audio.network(
                AppValues.notificationSound,
              )
            : Audio(
                AppValues.notificationSound,
              ),
        autoStart: false,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> playAudio() async {
    try {
      await _audio.play();
    } catch (e) {
      log(e.toString());
    }
  }

  int? streamDataLengthOld;

  int? _streamDataLength;

  int? get streamDataLength => _streamDataLength;

  set streamDataLength(final int? value) {
    streamDataLengthOld = streamDataLength;
    _streamDataLength = value;
  }

  void streamDataBoth(final int? value) {
    streamDataLengthOld = value;
    _streamDataLength = value;
  }

  Stream<QuerySnapshot<Object?>> get streamAdverts =>
      _advertsRepository.streamAdverts;

  MainScreenEnums _screenType = MainScreenEnums.home;

  MainScreenEnums get screenType => _screenType;

  set screenType(final MainScreenEnums value) {
    _screenType = value;
    update();
  }

  void onNavTap(final MainScreenEnums type) {
    if (type == MainScreenEnums.create) {
      goToCreate();
    } else {
      screenType = type;
    }
  }

  Future<void> goToCreate() async {
    try {
      final res = await Get.toNamed(AppRoutes.create);
      if (res != null) {
        switch (screenType) {
          case MainScreenEnums.home:
            final HomeController hc = Get.find<HomeController>();
            hc.adverts.add(res as AdvertModel);
            hc.update();
            break;
          case MainScreenEnums.adverts:
            final AdvertsController ac = Get.find<AdvertsController>();
            ac.myAdverts.add(res as AdvertModel);
            ac.update();
            break;
          default:
            break;
        }
      }
    } catch (_) {}
  }

  void goToAbout() => Get.toNamed(AppRoutes.about);

  void unFocus() => Get.focusScope?.unfocus();

  void willPopScope() {
    final bool res = screenType == MainScreenEnums.home;
    res ? Get.back() : screenType = MainScreenEnums.home;
  }
}
