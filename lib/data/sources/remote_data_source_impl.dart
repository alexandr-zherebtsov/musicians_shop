import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/domain/models/advert_model.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/enums/file_type.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class RemoteDataSourceImpl extends RemoteDataSource {
  final FirebaseAuth _fa = FirebaseAuth.instance;
  final FirebaseStorage _fs = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<bool> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
     await _fa.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
     return true;
    }
    catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<User?> registerEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential res = await _fa.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return res.user;
    }
    catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _fa.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<bool> deleteUser() async {
    try {
      await _fa.currentUser!.delete();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<UserModel?> getUser(String uid) async {
    try {
      return await _db.collection(
        AppValues.collectionUsers,
      ).doc(uid).get().then((DocumentSnapshot snapshot) {
        final Object? res = snapshot.data();
        if (res != null) {
          return UserModel.fromJson(res as Map<String, dynamic>);
        } else {
          return null;
        }
      });
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<UserModel?> createUser(UserModel user) async {
    try {
      return await _db.collection(
        AppValues.collectionUsers,
      ).doc(user.id!).set(user.toJson()).then(
        (value) async {
          return await getUser(user.id!);
        },
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<bool> deleteUserData(String id) async {
    try {
      await _db.collection(
        AppValues.collectionUsers,
      ).doc(id).delete();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> editUserData(UserModel user) async {
    try {
      await _db.collection(
        AppValues.collectionUsers,
      ).doc(user.id).update(user.toJson());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<String?> uploadFile({
    required XFile file,
    required FileTypeEnums type,
  }) async {
    try {
      if (kIsWeb) {
        String? imgUrl;
        final Reference ref = _fs.ref().child(getFileUrl(type) + getFileFormatFromString(
          file.name,
          dot: true,
        ));
        await ref.putData(
          await file.readAsBytes(),
          SettableMetadata(
            contentType: getFileType(
              fileName: file.name,
              type: type,
            ),
          ),
        ).whenComplete(() async {
          await ref.getDownloadURL().then((String v) {
            imgUrl = v;
          });
        });
        return imgUrl;
      } else {
        final UploadTask ut = _fs.ref().child(
          getFileUrl(type) + getFileFormatFromFile(
            path: file.path,
            name: file.name,
            dot: true,
          ),
        ).putFile(File(file.path));
        final String imgUrl = await(await ut).ref.getDownloadURL();
        return imgUrl;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<bool> deleteFile(String fileUrl) async {
    try {
      await _fs.refFromURL(fileUrl).delete();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<List<AdvertModel>> getAdverts() async {
    try {
      final QuerySnapshot qs = await _db.collection(
        AppValues.collectionAdverts,
      ).orderBy('updatedAt').get();
      final List<AdvertModel> res = (qs.docs).map((e) {
        return AdvertModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      return res;
    } catch (e) {
      log(e.toString());
      return <AdvertModel>[];
    }
  }

  @override
  Future<bool> editAdvert(AdvertModel advert) async {
    try {
      await _db.collection(
        AppValues.collectionAdverts,
      ).doc(advert.id).update(advert.toJson());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<List<AdvertModel>> getMyAdverts(String uid) async {
    try {
      final QuerySnapshot qs = await _db.collection(
        AppValues.collectionAdverts,
      ).where('uid', isEqualTo: uid).orderBy('updatedAt').get();
      final List<AdvertModel> res = (qs.docs).map((e) {
        return AdvertModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      return res;
    } catch (e) {
      log(e.toString());
      return <AdvertModel>[];
    }
  }

  @override
  Future<List<AdvertModel>> getLikedAdverts(String uid) async {
    try {
      final QuerySnapshot qs = await _db.collection(
        AppValues.collectionAdverts,
      ).where('likes', arrayContains: uid).orderBy('updatedAt').get();
      final List<AdvertModel> res = (qs.docs).map((e) {
        return AdvertModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
      return res;
    } catch (e) {
      log(e.toString());
      return <AdvertModel>[];
    }
  }
}
