import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/nav_bottom_bar.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
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
        title: StringsKeys.musicianShop.tr,
        actions: <IconButton>[
          IconButton(
            tooltip: StringsKeys.about.tr,
            icon: const Icon(
              Icons.info_outline,
            ),
            onPressed: controller.goToAbout,
          )
        ],
        bottomDivider: _divider(controller.screenType),
      ),
      body: body,
      bottomNavigationBar: NavBottomBar(controller: controller),
    );
  }

  static bool _divider(MainScreenEnums screenType) => screenType != MainScreenEnums.posts;
}

