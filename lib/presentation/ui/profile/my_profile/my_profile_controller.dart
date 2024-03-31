import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musicians_shop/data/local/preference_manager.dart';
import 'package:musicians_shop/data/models/advert_model.dart';
import 'package:musicians_shop/data/models/file_to_upload.dart';
import 'package:musicians_shop/data/models/user_model.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/remote/auth/auth_repository.dart';
import 'package:musicians_shop/data/remote/file/file_repository.dart';
import 'package:musicians_shop/data/remote/push_notification/push_notification_repository.dart';
import 'package:musicians_shop/data/remote/user/user_repository.dart';
import 'package:musicians_shop/presentation/router/routes.dart';
import 'package:musicians_shop/presentation/ui/profile/widgets/password_dialog.dart';
import 'package:musicians_shop/presentation/widgets/app_dialog.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class MyProfileController extends GetxController {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final IFileRepository _fileRepository;
  final IAdvertsRepository _advertsRepository;
  final IPushNotificationRepository _pushNotificationRepository;
  final IPreferenceManager _pref;

  MyProfileController(
    this._authRepository,
    this._userRepository,
    this._fileRepository,
    this._advertsRepository,
    this._pushNotificationRepository,
    this._pref,
  );

  final TextEditingController passwordTC = TextEditingController();
  RxBool passwordLoader = false.obs;

  UserModel? user;

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

  Future<void> changeAvatarWeb() async {
    Get.back();
    try {
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
        initialDirectory:
            MainUtils.isNotMobileApp ? null : await MainUtils.findGalleryPath(),
      );
      if (pickedFile != null) {
        screenLoader = true;
        final String? imageUrl = await _fileRepository.uploadFile(
          FileToUpload(
            platformFile: pickedFile.files.first,
            type: FileTypeEnums.userPhoto,
          ),
        );
        if (imageUrl != null) {
          await Future.wait([
            deleteUserImage(),
            setNewUserPhoto(imageUrl),
          ]);
        } else {
          MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    screenLoader = false;
  }

  Future<void> changeAvatarMobile(final ImageSource source) async {
    Get.back();
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
      );
      if (xFile != null) {
        screenLoader = true;
        final String? imageUrl = await _fileRepository.uploadFile(
          FileToUpload(
            xFile: xFile,
            type: FileTypeEnums.userPhoto,
          ),
        );
        if (imageUrl != null) {
          await Future.wait([
            deleteUserImage(),
            setNewUserPhoto(imageUrl),
          ]);
        } else {
          MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    screenLoader = false;
  }

  Future<void> deleteAvatar() async {
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
      MainUtils.showAppNotification(StringsKeys.done.tr);
    } else {
      MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  Future<void> deleteUserImage() async {
    try {
      if ((user?.photo ?? '').isNotEmpty) {
        await _fileRepository.deleteFile(user!.photo!);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> onTapEdit() async {
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

  Future<void> deleteUser() async {
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
          MainUtils.showAppNotification(StringsKeys.done.tr);
        } else {
          screenError = true;
          MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
        }
      } else {
        MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
      }
      screenLoader = false;
    } else {
      MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  Future<void> refreshAdverts() async {
    final List<AdvertModel> allAdverts = await _advertsRepository.getAdverts();
    List<AdvertModel> likedAdverts = <AdvertModel>[];
    List<AdvertModel> myAdverts = <AdvertModel>[];
    List<String> images = <String>[];

    for (int i = 0; i < allAdverts.length; i++) {
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
    for (int i = 0; i < likedAdverts.length; i++) {
      await _advertsRepository.editAdvert(likedAdverts[i]);
    }
  }

  Future<void> deleteAdverts(List<AdvertModel> myAdverts) async {
    for (int i = 0; i < myAdverts.length; i++) {
      await _advertsRepository.deleteAdvert(myAdverts[i].id!);
    }
  }

  Future<void> deleteImages(List<String> images) async {
    for (int i = 0; i < images.length; i++) {
      await _fileRepository.deleteFile(images[i]);
    }
  }

  Future<void> onTapSignOut() async {
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

  Future<void> logOut() async {
    await _pushNotificationRepository.removeFcmToken();
    await Future.wait([
      _appSignOut(),
      _clearPref(),
    ]);
    Get.offAllNamed(AppRoutes.start);
  }

  Future<void> _appSignOut() async => await _authRepository.logOut();

  Future<void> _clearPref() async => await _pref.clear();
}
