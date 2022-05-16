import 'package:flutter/material.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/nav_item.dart';
import 'package:musicians_shop/shared/widgets/divider_widget.dart';

class NavBottomBar extends StatelessWidget {
  final MainController controller;

  const NavBottomBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                screenType: MainScreenEnums.posts,
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
