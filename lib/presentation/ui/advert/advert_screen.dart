import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/advert/advert_controller.dart';
import 'package:musicians_shop/presentation/ui/advert/components/advert_desktop.dart';
import 'package:musicians_shop/presentation/ui/advert/components/advert_mobile.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';
import 'package:musicians_shop/shared/widgets/app_bar_widget.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';

class AdvertScreen extends StatelessWidget {
  const AdvertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvertController>(
      autoRemove: false,
      builder: (AdvertController controller) {
        return WillPopScope(
          onWillPop: controller.willPopScope,
          child: Scaffold(
            appBar: AppBarWidget(
              title: StringsKeys.advert.tr,
              back: Get.back,
              actions: controller.screenLoader || controller.screenError ? null : controller.uid != controller.advert.uid ? [
                IconButton(
                  tooltip: StringsKeys.author.tr,
                  icon: Icon(AppIcons.personFilled),
                  onPressed: controller.goAuthor,
                ),
              ] : [
                IconButton(
                  tooltip: StringsKeys.edit.tr,
                  icon: Icon(AppIcons.edit),
                  onPressed: controller.goToEdit,
                ),
                IconButton(
                  tooltip: StringsKeys.delete.tr,
                  icon: Icon(AppIcons.deleteFilled),
                  onPressed: controller.delete,
                ),
              ],
            ),
            body: Builder(
              builder: (_) {
                if (controller.screenLoader) {
                  return const AppProgress();
                } else if (controller.screenError) {
                  return const AppErrorWidget();
                } else {
                  return _AdvertScreen(
                    controller: controller,
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class _AdvertScreen extends GetResponsiveView<AdvertController> {
  @override
  final AdvertController controller;

  _AdvertScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget desktop() => AdvertDesktop(
    controller: controller,
  );

  @override
  Widget tablet() => AdvertDesktop(
    controller: controller,
  );

  @override
  Widget phone() => AdvertMobile(
    controller: controller,
  );

  @override
  Widget builder() => AdvertMobile(
    controller: controller,
  );
}


