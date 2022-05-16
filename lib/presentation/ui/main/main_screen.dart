import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/home/home_screen.dart';
import 'package:musicians_shop/presentation/ui/main/components/main_screen_desktop.dart';
import 'package:musicians_shop/presentation/ui/main/components/main_screen_mobile.dart';
import 'package:musicians_shop/presentation/ui/main/components/main_screen_tablet.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/posts/posts_screen.dart';
import 'package:musicians_shop/presentation/ui/profile/profile_screen.dart';
import 'package:musicians_shop/presentation/ui/statistic/statistic_screen.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (MainController controller) {
        return WillPopScope(
          onWillPop: controller.willPopScope,
          child: _MainScreen(
            controller: controller,
            body: _buildBody(controller.screenType),
          ),
        );
      },
    );
  }

  Widget _buildBody(MainScreenEnums screenType) {
    switch (screenType) {
      case MainScreenEnums.home:
        return const HomeScreen();
      case MainScreenEnums.posts:
        return const PostsScreen();
      case MainScreenEnums.statistic:
        return const StatisticScreen();
      case MainScreenEnums.profile:
        return const ProfileScreen();
      default:
        return const AppErrorWidget();
    }
  }
}

class _MainScreen extends GetResponsiveView<MainController> {
  @override
  final MainController controller;
  final Widget body;

  _MainScreen({
    Key? key,
    required this.controller,
    required this.body,
  }) : super(key: key);

  @override
  Widget desktop() => MainScreenDesktop(
    controller: controller,
    body: body,
  );

  @override
  Widget tablet() => MainScreenTablet(
    controller: controller,
    body: body,
  );

  @override
  Widget phone() => MainScreenMobile(
    controller: controller,
    body: body,
  );

  @override
  Widget builder() => MainScreenMobile(
    controller: controller,
    body: body,
  );
}
