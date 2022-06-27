import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';

class NavItemMobile extends StatelessWidget {
  final MainController controller;
  final MainScreenEnums screenType;

  const NavItemMobile({
    Key? key,
    required this.controller,
    required this.screenType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _getIcon(
          controller: controller,
          screenType: screenType,
        ),
        color: _getIconColor(
          controller: controller,
          screenType: screenType,
        ),
        size: _getIconSize(
          controller: controller,
          screenType: screenType,
        ),
      ),
      iconSize: 32,
      tooltip: _getTitle(screenType),
      onPressed: () => controller.onNavTap(screenType),
    );
  }

  double _getIconSize({
    required MainController controller,
    required MainScreenEnums screenType,
  }) {
    if (screenType == MainScreenEnums.create) {
      return 30;
    } else if (screenType == controller.screenType) {
      return 29;
    } else {
      return 26;
    }
  }
}

class NavItemDesktop extends StatelessWidget {
  final MainController controller;
  final MainScreenEnums screenType;

  const NavItemDesktop({
    Key? key,
    required this.controller,
    required this.screenType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.scaffoldBackgroundColor,
      child: InkWell(
        child: SizedBox(
          height: 50,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 60,
                child: Icon(
                  _getIcon(
                    controller: controller,
                    screenType: screenType,
                  ),
                  color: _getIconColor(
                    controller: controller,
                    screenType: screenType,
                  ),
                  size: _getIconSize(
                    controller: controller,
                    screenType: screenType,
                  ),
                ),
              ),
              Text(
                _getTitle(screenType),
                softWrap: false,
                style: Get.theme.textTheme.button,
              ),
            ],
          ),
        ),
        onTap: () => controller.onNavTap(screenType),
      ),
    );
  }

  double _getIconSize({
    required MainController controller,
    required MainScreenEnums screenType,
  }) {
    return screenType == controller.screenType ? 34 : 32;
  }
}

Color? _getIconColor({
  required MainController controller,
  required MainScreenEnums screenType,
}) {
  return screenType == controller.screenType ? Get.theme.primaryColor : Get.theme.iconTheme.color;
}

IconData _getIcon({
  required MainController controller,
  required MainScreenEnums screenType,
}) {
  switch (screenType) {
    case MainScreenEnums.home:
      return screenType == controller.screenType ? AppIcons.homeFilled : AppIcons.home;
    case MainScreenEnums.adverts:
      return screenType == controller.screenType ? AppIcons.notesFilled : AppIcons.notes;
    case MainScreenEnums.create:
      return AppIcons.add;
    case MainScreenEnums.statistic:
      return screenType == controller.screenType ? AppIcons.graphFilled : AppIcons.graph;
    case MainScreenEnums.profile:
      return screenType == controller.screenType ? AppIcons.personFilled : AppIcons.person;
    default:
      return AppIcons.circle;
  }
}

String _getTitle(MainScreenEnums screenType) {
  switch (screenType) {
    case MainScreenEnums.home:
      return StringsKeys.home.tr;
    case MainScreenEnums.adverts:
      return StringsKeys.adverts.tr;
    case MainScreenEnums.create:
      return StringsKeys.create.tr;
    case MainScreenEnums.statistic:
      return StringsKeys.statistic.tr;
    case MainScreenEnums.profile:
      return StringsKeys.profile.tr;
    default:
      return StringsKeys.page.tr;
  }
}
