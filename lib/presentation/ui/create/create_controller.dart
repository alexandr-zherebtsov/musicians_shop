import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/models/advert_model.dart';
import 'package:musicians_shop/data/models/brand_model.dart';
import 'package:musicians_shop/data/models/file_to_upload.dart';
import 'package:musicians_shop/data/models/instrument_type_model.dart';
import 'package:musicians_shop/data/models/user_model.dart';
import 'package:musicians_shop/data/remote/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/remote/brands/brands_repository.dart';
import 'package:musicians_shop/data/remote/file/file_repository.dart';
import 'package:musicians_shop/data/remote/instrument_types/instrument_types_repository.dart';
import 'package:musicians_shop/data/remote/user/user_repository.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class CreateController extends GetxController {
  final String _uid;
  final IFileRepository _fileRepository;
  final IUserRepository _userRepository;
  final IBrandsRepository _brandsRepository;
  final IAdvertsRepository _advertsRepository;
  final IInstrumentTypesRepository _instrumentTypesRepository;

  CreateController(
    this._uid,
    this._fileRepository,
    this._userRepository,
    this._brandsRepository,
    this._advertsRepository,
    this._instrumentTypesRepository,
  );

  final TextEditingController headlineTC = TextEditingController();
  final TextEditingController priceTC = TextEditingController();
  final TextEditingController descriptionTC = TextEditingController();

  UserModel? user;
  AdvertModel? editableAdvert;
  AdvertModel? newAdvert;
  double? price;
  AdvertModel? refreshResult;

  List<BrandModel> brands = <BrandModel>[];
  List<InstrumentTypeModel> instrumentTypes = <InstrumentTypeModel>[];

  List<String> acquisitionImages = <String>[];
  List<PlatformFile> selectedImages = <PlatformFile>[];
  List<String> deletedImages = <String>[];
  List<String> finalImages = <String>[];

  BrandModel? _brand;

  BrandModel? get brand => _brand;

  set brand(final BrandModel? value) {
    _brand = value;
    update();
  }

  InstrumentTypeModel? _instrumentType;

  InstrumentTypeModel? get instrumentType => _instrumentType;

  set instrumentType(final InstrumentTypeModel? value) {
    _instrumentType = value;
    update();
  }

  bool _screenLoader = false;

  bool get screenLoader => _screenLoader;

  set screenLoader(final bool value) {
    _screenLoader = value;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    screenLoader = true;
    await Future.wait([
      getUser(),
      getBrands(),
      getInstrumentTypes(),
    ]);
    editableAdvert = Get.arguments as AdvertModel?;
    if (editableAdvert != null) {
      setAdvertData();
    }
    screenLoader = false;
  }

  Future<void> getUser() async {
    user = await _userRepository.getUser(_uid);
  }

  Future<void> getBrands() async {
    brands = await _brandsRepository.getBrands();
  }

  Future<void> getInstrumentTypes() async {
    instrumentTypes = await _instrumentTypesRepository.getInstrumentTypes();
  }

  void setAdvertData() {
    headlineTC.text = editableAdvert?.headline ?? '';
    priceTC.text = editableAdvert?.price?.toString() ?? '';
    descriptionTC.text = editableAdvert?.description ?? '';
    acquisitionImages.addAll(editableAdvert?.images ?? []);
    _instrumentType =
        instrumentTypes.firstWhere((e) => e.id == editableAdvert?.type?.id);
    _brand = brands.firstWhere((e) => e.id == editableAdvert?.brand?.id);
  }

  void addImage() async {
    unFocus();
    final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      initialDirectory:
          MainUtils.isNotMobileApp ? null : await MainUtils.findGalleryPath(),
    );
    if (pickedFile != null) {
      selectedImages.add(pickedFile.files[0]);
      update();
    }
  }

  void removeAcquisition(String e) {
    deletedImages.add(e);
    acquisitionImages.remove(e);
    update();
  }

  void removeSelected(PlatformFile e) {
    selectedImages.remove(e);
    update();
  }

  void save() async {
    price = double.tryParse(priceTC.text);
    if (price != null && validator()) {
      screenLoader = true;
      try {
        await Future.wait([
          deleteImages(),
          downloadImages(),
        ]);
        editableAdvert == null ? await createAdvert() : await editAdvert();
      } catch (e) {
        log(e.toString());
        MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
      }
      screenLoader = false;
    } else {
      MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  Future<void> downloadImages() async {
    List<String> images = acquisitionImages;
    for (int i = 0; i < selectedImages.length; i++) {
      final String? imageUrl = await _fileRepository.uploadFile(
        FileToUpload(
          platformFile: selectedImages[i],
          type: FileTypeEnums.advertPhoto,
        ),
      );
      if (imageUrl != null) {
        images.add(imageUrl);
      }
    }
    finalImages = images;
  }

  Future<void> deleteImages() async {
    for (int i = 0; i < deletedImages.length; i++) {
      await _fileRepository.deleteFile(deletedImages[i]);
    }
  }

  Future<void> createAdvert() async {
    newAdvert = AdvertModel(
      id: MainUtils.generateId('AD'),
      uid: _uid,
      headline: headlineTC.text.trim(),
      price: price,
      description: descriptionTC.text.trim(),
      images: finalImages,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
      likes: <String>[],
      type: _instrumentType,
      brand: _brand,
      city: user?.city,
    );
    final bool res = await _advertsRepository.createAdvert(newAdvert!);
    if (res) {
      MainUtils.showAppNotification(StringsKeys.done.tr);
      Get.back(result: newAdvert);
    } else {
      MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  Future<void> editAdvert() async {
    editableAdvert!.headline = headlineTC.text.trim();
    editableAdvert!.price = price;
    editableAdvert!.description = descriptionTC.text.trim();
    editableAdvert!.images = finalImages;
    final bool res = await _advertsRepository.editAdvert(editableAdvert!);
    if (res) {
      MainUtils.showAppNotification(StringsKeys.done.tr);
      Get.back(result: editableAdvert);
    } else {
      MainUtils.showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  bool validator() {
    return brand != null &&
        instrumentType != null &&
        headlineTC.text.isNotEmpty &&
        priceTC.text.isNotEmpty &&
        descriptionTC.text.isNotEmpty &&
        (acquisitionImages.isNotEmpty || selectedImages.isNotEmpty);
  }

  void unFocus() => Get.focusScope?.unfocus();
}
