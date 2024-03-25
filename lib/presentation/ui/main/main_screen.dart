import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/adverts/adverts_screen.dart';
import 'package:musicians_shop/presentation/ui/home/home_screen.dart';
import 'package:musicians_shop/presentation/ui/main/components/main_screen_desktop.dart';
import 'package:musicians_shop/presentation/ui/main/components/main_screen_mobile.dart';
import 'package:musicians_shop/presentation/ui/main/components/main_screen_tablet.dart';
import 'package:musicians_shop/presentation/ui/main/enums/main_screen_enums.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/profile/my_profile/my_profile_screen.dart';
import 'package:musicians_shop/presentation/ui/statistic/statistic_screen.dart';
import 'package:musicians_shop/presentation/widgets/app_error_widget.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainController _controller;
  late final StreamSubscription<QuerySnapshot<Object?>> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<MainController>();
    _streamSubscription = _controller.streamAdverts.listen((data) {
      if (data.docs.isNotEmpty) {
        final int length = data.docs.length;
        if (_controller.streamDataLength == null &&
            _controller.streamDataLengthOld == null) {
          _controller.streamDataBoth(length);
        } else {
          _controller.streamDataLength = length;
        }
        if ((_controller.streamDataLength ?? 0) >
            (_controller.streamDataLengthOld ?? 0)) {
          MainUtils.showAppNotification(StringsKeys.newAdvertCreated.tr);
          _controller.playAudio();
        } else if ((_controller.streamDataLength ?? 0) <
            (_controller.streamDataLengthOld ?? 0)) {
          _controller.streamDataBoth(length);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: _controller,
      builder: (MainController controller) {
        return GestureDetector(
          onTap: controller.unFocus,
          child: PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (!didPop) {
                controller.willPopScope();
              }
            },
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
    required this.controller,
  });

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

  Widget _buildBody(final MainScreenEnums screenType) {
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
