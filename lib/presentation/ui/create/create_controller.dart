import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/remote/adverts_repository.dart';
import 'package:musicians_shop/data/remote/brands_repository.dart';
import 'package:musicians_shop/data/remote/file_repository.dart';
import 'package:musicians_shop/data/remote/instrument_types_repository.dart';
import 'package:musicians_shop/data/remote/user_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/domain/models/brand_model.dart';
import 'package:musicians_shop/domain/models/instrument_type_model.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class CreateController extends GetxController {
  final String _uid;
  final FileRepository _fileRepository;
  final UserRepository _userRepository;
  final BrandsRepository _brandsRepository;
  final AdvertsRepository _advertsRepository;
  final InstrumentTypesRepository _instrumentTypesRepository;

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
  set brand(BrandModel? brand) {
    _brand = brand;
    update();
  }

  InstrumentTypeModel? _instrumentType;
  InstrumentTypeModel? get instrumentType => _instrumentType;
  set instrumentType(InstrumentTypeModel? instrumentType) {
    _instrumentType = instrumentType;
    update();
  }

  bool _screenLoader = false;
  bool get screenLoader => _screenLoader;
  set screenLoader(bool screenLoader) {
    _screenLoader = screenLoader;
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
    _instrumentType = instrumentTypes.firstWhere((e) => e.id == editableAdvert?.type?.id);
    _brand = brands.firstWhere((e) => e.id == editableAdvert?.brand?.id);
  }

  void addImage() async {
    unFocus();
    final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      initialDirectory: isNotMobile() ? null : await findGalleryPath(),
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
        showAppNotification(StringsKeys.somethingWentWrong.tr);
      }
      screenLoader = false;
    } else {
      showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  Future<void> downloadImages() async {
    List<String> images = acquisitionImages;
    for (int i = 0; i < selectedImages.length; i++) {
      final String? imageUrl = await _fileRepository.uploadFile(
        file: selectedImages[i],
        type: FileTypeEnums.advertPhoto,
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
      id: generateId('AD'),
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
      showAppNotification(StringsKeys.done.tr);
      Get.back(result: newAdvert);
    } else {
      showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  Future<void> editAdvert() async {
    editableAdvert!.headline = headlineTC.text.trim();
    editableAdvert!.price = price;
    editableAdvert!.description = descriptionTC.text.trim();
    editableAdvert!.images = finalImages;
    final bool res = await _advertsRepository.editAdvert(editableAdvert!);
    if (res) {
      showAppNotification(StringsKeys.done.tr);
      Get.back(result: editableAdvert);
    } else {
      showAppNotification(StringsKeys.somethingWentWrong.tr);
    }
  }

  bool validator() {
    return brand != null && instrumentType != null && headlineTC.text.isNotEmpty
        && priceTC.text.isNotEmpty && descriptionTC.text.isNotEmpty &&
        (acquisitionImages.isNotEmpty || selectedImages.isNotEmpty);
  }

  void unFocus() => Get.focusScope?.unfocus();
}
