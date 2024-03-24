import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/models/brand_model.dart';
import 'package:musicians_shop/data/models/instrument_type_model.dart';
import 'package:musicians_shop/data/models/user_model.dart';
import 'package:musicians_shop/data/remote/brands/brands_repository.dart';
import 'package:musicians_shop/data/remote/instrument_types/instrument_types_repository.dart';
import 'package:musicians_shop/data/remote/user/user_repository.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class EditProfileController extends GetxController {
  final String? _uid;
  final IUserRepository _userRepository;
  final IInstrumentTypesRepository _instrumentTypesRepository;
  final IBrandsRepository _brandsRepository;

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
    user = await _userRepository.getUser(_uid!);
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
      favoriteInstruments =
          user?.favoriteInstruments ?? <InstrumentTypeModel>[];
      favoriteBrands = user?.favoriteBrands ?? <BrandModel>[];
      for (InstrumentTypeModel v in favoriteInstruments) {
        instrumentTypes.removeWhere((e) => e.id == v.id);
      }
      for (BrandModel v in favoriteBrands) {
        brands.removeWhere((e) => e.id == v.id);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void addFavoriteInstrumentType(InstrumentTypeModel? v) {
    if (v != null) {
      favoriteInstruments.add(v);
      instrumentTypes.removeWhere((e) => e.id == v.id);
      sortInstrumentTypes();
      update();
    }
  }

  void addFavoriteBrand(BrandModel? v) {
    if (v != null) {
      favoriteBrands.add(v);
      brands.removeWhere((e) => e.id == v.id);
      sortBrands();
      update();
    }
  }

  void deleteFavoriteInstrumentType(InstrumentTypeModel? v) {
    if (v != null) {
      favoriteInstruments.removeWhere((e) => e.id == v.id);
      instrumentTypes.add(v);
      sortInstrumentTypes();
      update();
    }
  }

  void deleteFavoriteBrand(BrandModel? v) {
    if (v != null) {
      favoriteBrands.removeWhere((e) => e.id == v.id);
      brands.add(v);
      sortBrands();
      update();
    }
  }

  void sortInstrumentTypes() {
    try {
      instrumentTypes.sort((a, b) {
        return a.type!.tr.toLowerCase().compareTo(b.type!.tr.toLowerCase());
      });
      final InstrumentTypeModel other =
          instrumentTypes.firstWhere((v) => v.id == '0');
      instrumentTypes.removeWhere((v) => v.id == '0');
      instrumentTypes.add(other);
    } catch (e) {
      log(e.toString());
    }
  }

  void sortBrands() {
    try {
      brands.sort((a, b) {
        return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
      });
      final BrandModel other = brands.firstWhere((v) => v.id == '0');
      brands.removeWhere((v) => v.id == '0');
      brands.add(other);
    } catch (e) {
      log(e.toString());
    }
  }

  void save() async {
    if (validator()) {
      final bool res = await _userRepository.editUserData(setUserData());
      if (res) {
        MainUtils.showAppNotification(StringsKeys.done.tr);
        Get.back(result: true);
      } else {
        MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
      }
    } else {
      MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
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
    return firstNameTC.text.isNotEmpty &&
        lastNameTC.text.isNotEmpty &&
        phoneNumberTC.text.length > 9 &&
        cityTC.text.isNotEmpty;
  }

  void unFocus() => Get.focusScope?.unfocus();
}
