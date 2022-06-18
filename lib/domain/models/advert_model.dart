import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musicians_shop/domain/models/brand_model.dart';
import 'package:musicians_shop/domain/models/instrument_type_model.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class AdvertModel {
  String? id;
  String? uid;
  String? headline;
  double? price;
  String? description;
  List<String>? images;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  List<String>? likes;
  InstrumentTypeModel? type;
  BrandModel? brand;
  String? city;
  double? userCount;

  AdvertModel({
    this.id,
    this.uid,
    this.headline,
    this.price,
    this.description,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.likes,
    this.type,
    this.brand,
    this.city,
    this.userCount,
  });

  AdvertModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    headline = json['headline'];
    price = doubleParser(json['price']);
    description = json['description'];
    images = json['images'] == null ? <String>[] : json['images'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    likes = json['likes'] == null ? <String>[] : json['likes'].cast<String>();
    type = json['type'] != null
        ? InstrumentTypeModel.fromJson(json['type'])
        : null;
    brand = json['brand'] != null
        ? BrandModel.fromJson(json['brand'])
        : null;
    city = json['city'];
    userCount = doubleParser(json['userCount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['headline'] = headline;
    data['price'] = price;
    data['description'] = description;
    data['images'] = images;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['likes'] = likes;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    data['city'] = city;
    data['userCount'] = 0.0;
    return data;
  }
}
