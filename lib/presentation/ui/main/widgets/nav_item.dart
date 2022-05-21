import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';

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
    return screenType == controller.screenType ? 36 : 34;
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
      return screenType == controller.screenType ? Icons.home : Icons.home_outlined;
    case MainScreenEnums.posts:
      return screenType == controller.screenType ? Icons.sticky_note_2 : Icons.sticky_note_2_outlined;
    case MainScreenEnums.create:
      return Icons.add_circle_outline;
    case MainScreenEnums.statistic:
      return screenType == controller.screenType ? Icons.poll_rounded : Icons.poll_outlined;
    case MainScreenEnums.profile:
      return screenType == controller.screenType ? Icons.person : Icons.person_outline;
    default:
      return Icons.circle;
  }
}

String _getTitle(MainScreenEnums screenType) {
  switch (screenType) {
    case MainScreenEnums.home:
      return StringsKeys.home.tr;
    case MainScreenEnums.posts:
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
