import 'package:cloud_firestore/cloud_firestore.dart';

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
  });

  AdvertModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    headline = json['headline'];
    price = json['price'];
    description = json['description'];
    images = json['images'] == null ? <String>[] : json['images'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    likes = json['likes'] == null ? <String>[] : json['likes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['headline'] = headline;
    data['price'] = price;
    data['images'] = images;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['likes'] = likes;
    return data;
  }
}
