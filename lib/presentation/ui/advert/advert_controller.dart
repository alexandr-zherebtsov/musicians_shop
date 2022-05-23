import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/repositories/file/file_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';
import 'package:musicians_shop/shared/widgets/app_dialog.dart';

class AdvertController extends GetxController {
  final FileRepository _fileRepository = Get.find<FileRepository>();
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

  void goToEdit() async {
    final res = await Get.toNamed(
      AppRoutes.create,
      arguments: advert,
    );
    if (res != null) {
      refreshResult = true;
      advert = res as AdvertModel;
      update();
    }
  }

  void goAuthor() async {
    if (advert.uid != null) {
      Get.toNamed(
        AppRoutes.userProfile,
        arguments: advert.uid,
      );
    } else {
      showToast(StringsKeys.somethingWentWrong.tr);
    }
  }

  bool advertDeleted = false;
  bool imagesDeleted = true;

  void delete() async {
    final res = await showAppDialog(
      title: StringsKeys.delete.tr + '?',
      subtitle: StringsKeys.deleteYourAdvert.tr + '?',
      first: StringsKeys.cancel.tr,
      second: StringsKeys.delete.tr,
    );
    if (res == true && advert.id != null) {
      screenLoader = true;
      await Future.wait([
        deleteAdvert(),
        deleteImages(),
      ]);
      if (advertDeleted && imagesDeleted) {
        screenLoader = false;
        showToast(StringsKeys.done.tr);
        willPopScope();
      } else {
        screenLoader = false;
        showToast(StringsKeys.somethingWentWrong.tr);
        if (advertDeleted) {
          willPopScope();
        }
      }
    }
  }

  Future<void> deleteAdvert() async {
    advertDeleted = await _advertsRepository.deleteAdvert(advert.id!);
    refreshResult = true;
  }

  Future<void> deleteImages() async {
    if ((advert.images?? []).isNotEmpty) {
      for (int i = 0; i < advert.images!.length; i++) {
        final bool = await _fileRepository.deleteFile(advert.images![i]);
        if (!bool) {
          imagesDeleted = false;
        }
      }
    }
  }

  Future<bool> willPopScope() async {
    Get.back(result: refreshResult);
    return true;
  }
}
