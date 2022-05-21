import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/home/home_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/advert_card.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';

class HomeScreen extends GetView<HomeController> {
  final ResponsiveScreen screen;

  const HomeScreen({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController controller) {
        if (controller.screenLoader) {
          return const AppProgress();
        } else if (controller.screenError) {
          return const AppErrorWidget();
        } else if (controller.adverts.isEmpty) {
          return const AppErrorWidget(
            title: StringsKeys.thereAreNoAdverts,
          );
        }
        else {
          return ListView.builder(
            itemCount: controller.adverts.length,
            itemBuilder: (_, int i) {
              return AdvertCard(
                screen: screen,
                advert: controller.adverts[i],
                uid: controller.uid,
                onTapCard: () => controller.goToAdvert(controller.adverts[i]),
                onTapLike: () => controller.likeAdvert(controller.adverts[i]),
              );
            },
          );
        }
      },
    );
  }
}
