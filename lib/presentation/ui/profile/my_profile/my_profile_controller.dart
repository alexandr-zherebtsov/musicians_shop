import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/remote_repositories/adverts_repository.dart';
import 'package:musicians_shop/data/remote_repositories/auth_repository.dart';
import 'package:musicians_shop/data/remote_repositories/file_repository.dart';
import 'package:musicians_shop/data/remote_repositories/user_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/presentation/ui/profile/widgets/password_dialog.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
import 'package:musicians_shop/shared/utils/utils.dart';
import 'package:musicians_shop/shared/widgets/app_dialog.dart';

class MyProfileController extends GetxController {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final FileRepository _fileRepository;
  final AdvertsRepository _advertsRepository;
  final FirebaseMessaging _fms;

  MyProfileController(
    this._authRepository,
    this._userRepository,
    this._fileRepository,
    this._advertsRepository,
    this._fms,
  );

  final TextEditingController passwordTC = TextEditingController();
  RxBool passwordLoader = false.obs;

  UserModel? user;

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
    await getUser();
    screenLoader = false;
  }

  Future<void> getUser() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      user = await _userRepository.getUser(uid);
      if (user == null) {
        screenError = true;
      }
    } else {
      screenError = true;
    }
  }

  void changeAvatar() async {
    Get.back();
    try {
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        initialDirectory: isNotMobile() ? null : await findGalleryPath(),
      );
      if (pickedFile != null) {
        screenLoader = true;
        final String? imageUrl = await _fileRepository.uploadFile(
          file: pickedFile.files[0],
          type: FileTypeEnums.userPhoto,
        );
        if (imageUrl != null) {
          await Future.wait([
            deleteUserImage(),
            setNewUserPhoto(imageUrl),
          ]);
        } else {
          showAppNotification(StringsKeys.somethingWentWrong.tr);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    screenLoader = false;
  }

  void deleteAvatar() async {
    Get.back();
    try {
      screenLoader = true;
      await Future.wait([
        deleteUserImage(),
        setNewUserPhoto(null),
      ]);
    } catch (e) {
      log(e.toString());
    }
    screenLoader = false;
  }

  Future<void> setNewUserPhoto(String? photo) async {
    UserModel userEdited = user!;
    userEdited.updatedAt = Timestamp.now();
    userEdited.photo = photo;
    final bool res = await _userRepository.editUserData(userEdited);
    if (res) {
      user = userEdited;
      showAppNotification(StringsKeys.done.tr);
    } else {
      showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  Future<void> deleteUserImage() async {
    try {
      if ((user!.photo ?? '').isNotEmpty) {
        await _fileRepository.deleteFile(user!.photo!);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void onTapEdit() async {
    final res = await Get.toNamed(
      AppRoutes.editProfile,
    );
    if (res == true) {
      onInit();
    }
  }

  void onTapDeleteAccount() {
    Get.dialog(
      PasswordAlertDialog(
        loader: passwordLoader,
        passwordTC: passwordTC,
        confirmFunc: deleteUser,
      ),
    );
  }

  void deleteUser() async {
    if (passwordTC.text.length > 3) {
      passwordLoader(true);
      final bool auth = await _authRepository.signInEmailPassword(
        email: user!.email!,
        password: passwordTC.text,
      );
      passwordLoader(false);
      screenLoader = true;
      if (auth) {
        Get.back();
        if (user?.id != null) {
          await Future.wait([
            _userRepository.deleteUserData(user!.id!),
            deleteUserImage(),
            refreshAdverts(),
          ]);
          await _authRepository.deleteUser();
          logOut();
          showAppNotification(StringsKeys.done.tr);
        } else {
          screenError = true;
          showAppNotification(StringsKeys.somethingWentWrong.tr);
        }
      } else {
        showAppNotification(StringsKeys.somethingWentWrong.tr);
      }
      screenLoader = false;
    } else {
      showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  Future<void> refreshAdverts() async {
    final List<AdvertModel> allAdverts = await _advertsRepository.getAdverts();
    List<AdvertModel> likedAdverts = <AdvertModel>[];
    List<AdvertModel> myAdverts = <AdvertModel>[];
    List<String> images = <String>[];

    for (int i = 0; i < allAdverts.length; i ++) {
      if (allAdverts[i].likes?.contains(user!.id!) ?? false) {
        likedAdverts.add(allAdverts[i]);
        allAdverts[i].likes?.remove(user!.id!);
      }
      if (allAdverts[i].uid == user!.id!) {
        likedAdverts.remove(allAdverts[i]);
        myAdverts.add(allAdverts[i]);
        images.addAll(allAdverts[i].images ?? []);
      }
    }

    await Future.wait([
      removeLikes(likedAdverts),
      deleteAdverts(myAdverts),
      deleteImages(images),
    ]);
  }

  Future<void> removeLikes(List<AdvertModel> likedAdverts) async {
    for (int i = 0; i < likedAdverts.length; i ++) {
      await _advertsRepository.editAdvert(likedAdverts[i]);
    }
  }

  Future<void> deleteAdverts(List<AdvertModel> myAdverts) async {
    for (int i = 0; i < myAdverts.length; i ++) {
      await _advertsRepository.deleteAdvert(myAdverts[i].id!);
    }
  }

  Future<void> deleteImages(List<String> images) async {
    for (int i = 0; i < images.length; i ++) {
      await _fileRepository.deleteFile(images[i]);
    }
  }

  void onTapSignOut() async {
    final res = await showAppDialog(
      title: '${StringsKeys.signOut.tr}?',
      subtitle: StringsKeys.youReallyWantToSignOut.tr,
      first: StringsKeys.cancel.tr,
      second: StringsKeys.signOut.tr,
    );
    if (res == true) {
      logOut();
    }
  }

  void logOut() async {
    await Future.wait([
      _appSignOut(),
      _fmSignOut(),
    ]);
    Get.offAllNamed(AppRoutes.start);
  }

  Future<void> _appSignOut() async => await _authRepository.logOut();
  Future<void> _fmSignOut() async => await _fms.deleteToken();
}
