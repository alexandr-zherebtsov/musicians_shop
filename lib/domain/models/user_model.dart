import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? photo;
  String? name;
  String? city;
  String? email;
  String? surname;
  String? phoneNumber;
  String? aboutYourself;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  UserModel({
    this.id,
    this.photo,
    this.name,
    this.surname,
    this.city,
    this.email,
    this.phoneNumber,
    this.aboutYourself,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    name = json['name'];
    surname = json['surname'];
    city = json['city'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    aboutYourself = json['aboutYourself'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo'] = photo;
    data['name'] = name;
    data['surname'] = surname;
    data['city'] = city;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['aboutYourself'] = aboutYourself;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
