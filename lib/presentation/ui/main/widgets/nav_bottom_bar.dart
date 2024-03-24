import 'package:flutter/material.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/nav_item.dart';
import 'package:musicians_shop/presentation/widgets/divider_widget.dart';

class NavBottomBar extends StatelessWidget {
  final MainController controller;

  const NavBottomBar({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Column(
        children: <Widget>[
          const DividerWidget(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NavItemMobile(
                controller: controller,
                screenType: MainScreenEnums.home,
              ),
              NavItemMobile(
                controller: controller,
                screenType: MainScreenEnums.adverts,
              ),
              NavItemMobile(
                controller: controller,
                screenType: MainScreenEnums.create,
              ),
              NavItemMobile(
                controller: controller,
                screenType: MainScreenEnums.statistic,
              ),
              NavItemMobile(
                controller: controller,
                screenType: MainScreenEnums.profile,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
