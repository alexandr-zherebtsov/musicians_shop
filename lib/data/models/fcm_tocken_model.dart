import 'package:cloud_firestore/cloud_firestore.dart';

class FcmTokenModel {
  String? token;
  String? platform;
  String? os;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  FcmTokenModel({
    this.token,
    this.platform,
    this.os,
    this.createdAt,
    this.updatedAt,
  });

  FcmTokenModel.fromJson(final Map<String, dynamic> json) {
    token = json['token'];
    platform = json['platform'];
    os = json['os'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['platform'] = platform;
    data['os'] = os;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  FcmTokenModel copyWith({
    final String? token,
    final String? platform,
    final String? os,
    final Timestamp? createdAt,
    final Timestamp? updatedAt,
  }) {
    return FcmTokenModel(
      token: token ?? this.token,
      platform: platform ?? this.platform,
      os: os ?? this.os,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
