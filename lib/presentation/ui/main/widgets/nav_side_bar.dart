import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/nav_item.dart';
import 'package:musicians_shop/shared/constants/app_values.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class NavSidebar extends StatelessWidget {
  final MainController controller;
  final EdgeInsets margin;

  const NavSidebar({
    Key? key,
    required this.controller,
    this.margin = const EdgeInsets.only(right: 30),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      margin: margin,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(AppStyles.clipRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Hero(
                        tag: AppValues.heroMusicNoteOutlined,
                        child: Icon(
                          Icons.music_note_outlined,
                          color: Get.theme.primaryColor,
                          size: 42,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            StringsKeys.musicianShop.tr,
                            style: Get.theme.textTheme.headline3,
                          ),
                        ),
                        Tooltip(
                          message: StringsKeys.about.tr,
                          child: InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Icon(
                              Icons.info_outline,
                              color: Get.theme.primaryColor,
                              size: 12,
                            ),
                            onTap: controller.goToAbout,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          NavItemDesktop(
            controller: controller,
            screenType: MainScreenEnums.home,
          ),
          NavItemDesktop(
            controller: controller,
            screenType: MainScreenEnums.posts,
          ),
          NavItemDesktop(
            controller: controller,
            screenType: MainScreenEnums.statistic,
          ),
          NavItemDesktop(
            controller: controller,
            screenType: MainScreenEnums.profile,
          ),
          NavItemDesktop(
            controller: controller,
            screenType: MainScreenEnums.create,
          ),
        ],
      ),
    );
  }
}
