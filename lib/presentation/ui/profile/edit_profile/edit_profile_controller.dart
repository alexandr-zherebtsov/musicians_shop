import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/brands/brands_repository.dart';
import 'package:musicians_shop/data/repositories/instrument_types/instrument_types_repository.dart';
import 'package:musicians_shop/data/repositories/user/user_repository.dart';
import 'package:musicians_shop/domain/models/brand_model.dart';
import 'package:musicians_shop/domain/models/instrument_type_model.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class EditProfileController extends GetxController {
  final String _uid;
  final UserRepository _userRepository;
  final InstrumentTypesRepository _instrumentTypesRepository;
  final BrandsRepository _brandsRepository;

  EditProfileController(
    this._uid,
    this._userRepository,
    this._instrumentTypesRepository,
    this._brandsRepository,
  );

  final TextEditingController firstNameTC = TextEditingController();
  final TextEditingController lastNameTC = TextEditingController();
  final TextEditingController cityTC = TextEditingController();
  final TextEditingController emailTC = TextEditingController();
  final TextEditingController phoneNumberTC = TextEditingController();
  final TextEditingController aboutYourselfTC = TextEditingController();

  UserModel? user;
  List<BrandModel> brands = <BrandModel>[];
  List<InstrumentTypeModel> instrumentTypes = <InstrumentTypeModel>[];

  List<InstrumentTypeModel> favoriteInstruments = <InstrumentTypeModel>[];
  List<BrandModel> favoriteBrands = <BrandModel>[];

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
      getUser(),
      getInstrumentTypes(),
      getBrands(),
    ]);
    setDataToScreen();
    screenLoader = false;
  }

  Future<void> getUser() async {
    user = await _userRepository.getUser(_uid);
    if (user == null) {
      screenError = true;
    }
  }

  Future<void> getInstrumentTypes() async {
    instrumentTypes = await _instrumentTypesRepository.getInstrumentTypes();
  }

  Future<void> getBrands() async {
    brands = await _brandsRepository.getBrands();
  }

  void setDataToScreen() {
    try {
      firstNameTC.text = user?.firstName ?? '';
      lastNameTC.text = user?.lastName ?? '';
      phoneNumberTC.text = (user?.phone ?? '').replaceAll('+', '');
      cityTC.text = user?.city ?? '';
      aboutYourselfTC.text = user?.aboutYourself ?? '';
      favoriteInstruments = user?.favoriteInstruments ?? <InstrumentTypeModel>[];
      favoriteBrands = user?.favoriteBrands ?? <BrandModel>[];
    } catch (e) {
      log(e.toString());
    }
  }

  void addFavoriteInstrumentType(InstrumentTypeModel? v) {
    if (v != null) {
      favoriteInstruments.add(v);
      update();
    }
  }

  void addFavoriteBrand(BrandModel? v) {
    if (v != null) {
      favoriteBrands.add(v);
      update();
    }
  }

  void deleteFavoriteInstrumentType(String? id) {
    favoriteInstruments.removeWhere((v) => v.id == id);
    update();
  }

  void deleteFavoriteBrand(String? id) {
    favoriteBrands.removeWhere((v) => v.id == id);
    update();
  }

  void save() async {
    if (validator()) {
      final bool res = await _userRepository.editUserData(setUserData());
      if (res) {
        showAppNotification(StringsKeys.done.tr);
        Get.back(result: true);
      } else {
        showAppNotification(StringsKeys.somethingWentWrong.tr);
      }
    } else {
      showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  UserModel setUserData() {
    user!.firstName = firstNameTC.text.trim();
    user!.lastName = lastNameTC.text.trim();
    user!.phone = '+${phoneNumberTC.text}';
    user!.city = cityTC.text.trim();
    user!.aboutYourself = aboutYourselfTC.text.trim();
    user!.updatedAt = Timestamp.now();
    user!.favoriteInstruments = favoriteInstruments;
    user!.favoriteBrands = favoriteBrands;
    return user!;
  }

  bool validator() {
    return firstNameTC.text.isNotEmpty && lastNameTC.text.isNotEmpty &&
        phoneNumberTC.text.length > 9 && cityTC.text.isNotEmpty;
  }

  void unFocus() => Get.focusScope?.unfocus();
}
