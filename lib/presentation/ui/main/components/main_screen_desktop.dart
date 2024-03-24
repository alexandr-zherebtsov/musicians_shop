import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/nav_side_bar.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class MainScreenDesktop extends StatelessWidget {
  final MainController controller;
  final Widget body;

  const MainScreenDesktop({
    required this.controller,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Get.theme.colorScheme.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1230,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 30,
              right: 80,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  NavSidebar(controller: controller),
                  Expanded(
                    child: Material(
                      color: Get.theme.scaffoldBackgroundColor,
                      clipBehavior: Clip.hardEdge,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(AppStyles.clipRadius),
                        topLeft: Radius.circular(AppStyles.clipRadius),
                      ),
                      child: body,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
