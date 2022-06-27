import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/nav_bottom_bar.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';
import 'package:musicians_shop/shared/widgets/app_bar_widget.dart';

class MainScreenMobile extends StatelessWidget {
  final MainController controller;
  final Widget body;

  const MainScreenMobile({
    Key? key,
    required this.controller,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: StringsKeys.musiciansShop.tr,
        actions: <IconButton>[
          IconButton(
            tooltip: StringsKeys.about.tr,
            icon: Icon(AppIcons.info),
            onPressed: controller.goToAbout,
          )
        ],
        bottomDivider: _divider(controller.screenType),
      ),
      body: body,
      bottomNavigationBar: NavBottomBar(controller: controller),
    );
  }

  static bool _divider(MainScreenEnums screenType) {
    return screenType != MainScreenEnums.adverts && screenType != MainScreenEnums.statistic;
  }
}

