import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

final class AppIcons {
  static const IconData musicNote = Icons.music_note_outlined;
  static const IconData circle = Icons.circle;

  static IconData get home =>
      MainUtils.isApple ? CupertinoIcons.house : Icons.home_outlined;

  static IconData get homeFilled =>
      MainUtils.isApple ? CupertinoIcons.house_fill : Icons.home;

  static IconData get notes => MainUtils.isApple
      ? CupertinoIcons.square_favorites
      : Icons.sticky_note_2_outlined;

  static IconData get notesFilled => MainUtils.isApple
      ? CupertinoIcons.square_favorites_fill
      : Icons.sticky_note_2;

  static IconData get graph =>
      MainUtils.isApple ? CupertinoIcons.chart_bar_square : Icons.poll_outlined;

  static IconData get graphFilled => MainUtils.isApple
      ? CupertinoIcons.chart_bar_square_fill
      : Icons.poll_rounded;

  static IconData get person =>
      MainUtils.isApple ? CupertinoIcons.person : Icons.person_outline;

  static IconData get personFilled =>
      MainUtils.isApple ? CupertinoIcons.person_fill : Icons.person;

  static IconData get delete =>
      MainUtils.isApple ? CupertinoIcons.delete : Icons.delete_outline;

  static IconData get deleteFilled =>
      MainUtils.isApple ? CupertinoIcons.delete_solid : Icons.delete;

  static IconData get favorite =>
      MainUtils.isApple ? CupertinoIcons.heart : Icons.favorite_outline;

  static IconData get favoriteFilled =>
      MainUtils.isApple ? CupertinoIcons.heart_fill : Icons.favorite;

  static IconData get add =>
      MainUtils.isApple ? CupertinoIcons.add_circled : Icons.add_circle_outline;

  static IconData get plus =>
      MainUtils.isApple ? CupertinoIcons.plus : Icons.add;

  static IconData get clear =>
      MainUtils.isApple ? CupertinoIcons.clear : Icons.clear;

  static IconData get edit =>
      MainUtils.isApple ? CupertinoIcons.pen : Icons.edit;

  static IconData get search =>
      MainUtils.isApple ? CupertinoIcons.search : Icons.search;

  static IconData get addPhoto => MainUtils.isApple
      ? CupertinoIcons.camera_on_rectangle
      : Icons.add_a_photo_outlined;

  static IconData get gallery =>
      MainUtils.isApple ? CupertinoIcons.photo : Icons.image_outlined;

  static IconData get info =>
      MainUtils.isApple ? CupertinoIcons.info : Icons.info_outline;

  static IconData get error => MainUtils.isApple
      ? CupertinoIcons.exclamationmark_circle
      : Icons.error_outline;

  static IconData get mail =>
      MainUtils.isApple ? CupertinoIcons.mail_solid : Icons.mail;

  static IconData get lock =>
      MainUtils.isApple ? CupertinoIcons.padlock_solid : Icons.lock;

  static IconData get location =>
      MainUtils.isApple ? CupertinoIcons.location_solid : Icons.location_on;

  static IconData get arrowTriangleDown => MainUtils.isApple
      ? CupertinoIcons.arrowtriangle_down_fill
      : Icons.arrow_drop_down;

  static IconData get back =>
      MainUtils.isApple ? CupertinoIcons.back : Icons.arrow_back;
}
