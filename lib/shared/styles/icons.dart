import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class AppIcons {
  static const IconData musicNote = Icons.music_note_outlined;
  static final IconData home = isApple() ? CupertinoIcons.house : Icons.home_outlined;
  static final IconData homeFilled = isApple() ? CupertinoIcons.house_fill : Icons.home;
  static final IconData notes = isApple() ? CupertinoIcons.square_favorites : Icons.sticky_note_2_outlined;
  static final IconData notesFilled = isApple() ? CupertinoIcons.square_favorites_fill : Icons.sticky_note_2;
  static final IconData graph = isApple() ? CupertinoIcons.chart_bar_square : Icons.poll_outlined;
  static final IconData graphFilled = isApple() ? CupertinoIcons.chart_bar_square_fill : Icons.poll_rounded;
  static final IconData person = isApple() ? CupertinoIcons.person : Icons.person_outline;
  static final IconData personFilled = isApple() ? CupertinoIcons.person_fill : Icons.person;
  static final IconData delete = isApple() ? CupertinoIcons.delete : Icons.delete_outline;
  static final IconData deleteFilled = isApple() ? CupertinoIcons.delete_solid : Icons.delete;
  static final IconData favorite = isApple() ? CupertinoIcons.heart : Icons.favorite_outline;
  static final IconData favoriteFilled = isApple() ? CupertinoIcons.heart_fill : Icons.favorite;
  static final IconData add = isApple() ? CupertinoIcons.add_circled : Icons.add_circle_outline;
  static final IconData plus = isApple() ? CupertinoIcons.plus : Icons.add;
  static final IconData clear = isApple() ? CupertinoIcons.clear : Icons.clear;
  static final IconData edit = isApple() ? Icons.mode_edit_outlined : Icons.edit;
  static final IconData search = isApple() ? CupertinoIcons.search : Icons.search;
  static final IconData addPhoto = isApple() ? CupertinoIcons.camera_on_rectangle : Icons.add_a_photo_outlined;
  static final IconData info = isApple() ? CupertinoIcons.info : Icons.info_outline;
  static final IconData error = isApple() ? CupertinoIcons.exclamationmark_circle : Icons.error_outline;
  static final IconData mail = isApple() ? CupertinoIcons.mail_solid : Icons.mail;
  static final IconData lock = isApple() ? CupertinoIcons.padlock_solid : Icons.lock;
  static final IconData location = isApple() ? CupertinoIcons.location_solid : Icons.location_on;
  static final IconData arrowTriangleDown = isApple() ? CupertinoIcons.arrowtriangle_down_fill : Icons.arrow_drop_down;
  static final IconData back = isApple() ? CupertinoIcons.back : Icons.arrow_back;
  static const IconData circle = Icons.circle;
}
