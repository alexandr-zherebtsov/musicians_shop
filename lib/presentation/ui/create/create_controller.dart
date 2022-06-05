import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/adverts/adverts_repository.dart';
import 'package:musicians_shop/data/repositories/file/file_repository.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class CreateController extends GetxController {
  final FileRepository _fileRepository = Get.find<FileRepository>();
  final AdvertsRepository _advertsRepository = Get.find<AdvertsRepository>();

  final TextEditingController headlineTC = TextEditingController();
  final TextEditingController priceTC = TextEditingController();
  final TextEditingController descriptionTC = TextEditingController();

  AdvertModel? editableAdvert;
  AdvertModel? newAdvert;
  double? price;
  AdvertModel? refreshResult;

  List<String> acquisitionImages = <String>[];
  List<PlatformFile> selectedImages = <PlatformFile>[];
  List<String> deletedImages = <String>[];
  List<String> finalImages = <String>[];

  bool _screenLoader = false;
  bool get screenLoader => _screenLoader;
  set screenLoader(bool screenLoader) {
    _screenLoader = screenLoader;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    editableAdvert = Get.arguments as AdvertModel?;
    if (editableAdvert != null) {
      setAdvertData();
    }
  }

  void setAdvertData() {
    headlineTC.text = editableAdvert?.headline ?? '';
    priceTC.text = editableAdvert?.price?.toString() ?? '';
    descriptionTC.text = editableAdvert?.description ?? '';
    acquisitionImages.addAll(editableAdvert?.images ?? []);
    update();
  }

  void addImage() async {
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
      uid: FirebaseAuth.instance.currentUser!.uid,
      headline: headlineTC.text.trim(),
      price: price,
      description: descriptionTC.text.trim(),
      images: finalImages,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
      likes: <String>[],
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
    return headlineTC.text.isNotEmpty && priceTC.text.isNotEmpty && descriptionTC.text.isNotEmpty &&
        (acquisitionImages.isNotEmpty || selectedImages.isNotEmpty);
  }

  void unFocus() => Get.focusScope?.unfocus();
}
