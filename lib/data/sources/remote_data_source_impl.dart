import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicians_shop/data/sources/remote_data_source.dart';
import 'package:musicians_shop/domain/models/user_model.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';

class RemoteDataSourceImpl extends RemoteDataSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
     await _firebaseAuth.signInWithEmailAndPassword(
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
      final UserCredential res = await _firebaseAuth.createUserWithEmailAndPassword(
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
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<bool> deleteUser() async {
    try {
      await _firebaseAuth.currentUser!.delete();
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
        Object? res = snapshot.data();
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
}
