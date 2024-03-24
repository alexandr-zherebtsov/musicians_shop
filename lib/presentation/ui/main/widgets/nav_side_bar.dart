import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/nav_item.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/values/app_values.dart';

class NavSidebar extends StatelessWidget {
  final MainController controller;
  final EdgeInsets margin;

  const NavSidebar({
    required this.controller,
    this.margin = const EdgeInsets.only(right: 30),
    super.key,
  });

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
                          AppIcons.musicNote,
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
                            StringsKeys.musiciansShop.tr,
                            style: Get.theme.textTheme.headlineMedium,
                          ),
                        ),
                        Tooltip(
                          message: StringsKeys.about.tr,
                          child: InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: controller.goToAbout,
                            child: Icon(
                              AppIcons.info,
                              color: Get.theme.primaryColor,
                              size: 12,
                            ),
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
            screenType: MainScreenEnums.adverts,
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
