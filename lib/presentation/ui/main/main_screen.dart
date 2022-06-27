import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/data/repositories/push_notification/push_notification_repository.dart';
import 'package:musicians_shop/presentation/ui/home/home_screen.dart';
import 'package:musicians_shop/presentation/ui/main/components/main_screen_desktop.dart';
import 'package:musicians_shop/presentation/ui/main/components/main_screen_mobile.dart';
import 'package:musicians_shop/presentation/ui/main/components/main_screen_tablet.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/adverts/adverts_screen.dart';
import 'package:musicians_shop/presentation/ui/profile/my_profile/my_profile_screen.dart';
import 'package:musicians_shop/presentation/ui/statistic/statistic_screen.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(Get.find<PushNotificationRepository>()),
      builder: (MainController controller) {
        return GestureDetector(
          onTap: controller.unFocus,
          child: WillPopScope(
            onWillPop: controller.willPopScope,
            child: _MainScreen(
              controller: controller,
            ),
          ),
        );
      },
    );
  }
}

class _MainScreen extends GetResponsiveView<MainController> {
  @override
  final MainController controller;

  _MainScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget desktop() => MainScreenDesktop(
    controller: controller,
    body: _buildBody(controller.screenType),
  );

  @override
  Widget tablet() => MainScreenTablet(
    controller: controller,
    body: _buildBody(controller.screenType),
  );

  @override
  Widget phone() => MainScreenMobile(
    controller: controller,
    body: _buildBody(controller.screenType),
  );

  @override
  Widget builder() => MainScreenMobile(
    controller: controller,
    body: _buildBody(controller.screenType),
  );

  Widget _buildBody(MainScreenEnums screenType) {
    switch (screenType) {
      case MainScreenEnums.home:
        return HomeScreen(
          screen: screen,
        );
      case MainScreenEnums.adverts:
        return AdvertsScreen(
          screen: screen,
        );
      case MainScreenEnums.statistic:
        return StatisticScreen(
          screen: screen,
        );
      case MainScreenEnums.profile:
        return MyProfileScreen(
          screen: screen,
        );
      default:
        return const AppErrorWidget();
    }
  }
}
