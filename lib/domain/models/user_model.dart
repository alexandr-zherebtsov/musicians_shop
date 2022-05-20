import 'package:cloud_firestore/cloud_firestore.dart';

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
  });

  UserModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
