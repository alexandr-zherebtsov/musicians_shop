import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musicians_shop/data/models/brand_model.dart';
import 'package:musicians_shop/data/models/fcm_tocken_model.dart';
import 'package:musicians_shop/data/models/instrument_type_model.dart';

class UserModel {
  String? id;
  String? photo;
  String? firstName;
  String? city;
  String? email;
  String? lastName;
  String? phone;
  String? aboutYourself;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  List<InstrumentTypeModel>? favoriteInstruments;
  List<BrandModel>? favoriteBrands;
  List<FcmTokenModel>? fcmTokens;

  UserModel({
    this.id,
    this.photo,
    this.firstName,
    this.lastName,
    this.city,
    this.email,
    this.phone,
    this.aboutYourself,
    this.createdAt,
    this.updatedAt,
    this.favoriteInstruments,
    this.favoriteBrands,
    this.fcmTokens,
  });

  UserModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    city = json['city'];
    email = json['email'];
    phone = json['phone'];
    aboutYourself = json['aboutYourself'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['favoriteInstruments'] != null) {
      favoriteInstruments = <InstrumentTypeModel>[];
      json['favoriteInstruments'].forEach((v) {
        favoriteInstruments!.add(InstrumentTypeModel.fromJson(v));
      });
    }
    if (json['favoriteBrands'] != null) {
      favoriteBrands = <BrandModel>[];
      json['favoriteBrands'].forEach((v) {
        favoriteBrands!.add(BrandModel.fromJson(v));
      });
    }
    if (json['fcmTokens'] != null) {
      fcmTokens = <FcmTokenModel>[];
      json['fcmTokens'].forEach((v) {
        fcmTokens!.add(FcmTokenModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo'] = photo;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['city'] = city;
    data['email'] = email;
    data['phone'] = phone;
    data['aboutYourself'] = aboutYourself;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (favoriteInstruments != null) {
      data['favoriteInstruments'] =
          favoriteInstruments!.map((v) => v.toJson()).toList();
    }
    if (favoriteBrands != null) {
      data['favoriteBrands'] = favoriteBrands!.map((v) => v.toJson()).toList();
    }
    if (fcmTokens != null) {
      data['fcmTokens'] = fcmTokens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
