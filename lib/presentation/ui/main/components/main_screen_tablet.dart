import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/main/main_controller.dart';
import 'package:musicians_shop/presentation/ui/main/widgets/nav_side_bar.dart';

class MainScreenTablet extends StatelessWidget {
  final MainController controller;
  final Widget body;

  const MainScreenTablet({
    required this.controller,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Get.theme.scaffoldBackgroundColor,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: NavSidebar(
                    controller: controller,
                    margin: EdgeInsets.zero,
                  ),
                ),
                const VerticalDivider(
                  width: 1,
                  indent: 0,
                  thickness: 1,
                ),
              ],
            ),
            Expanded(
              child: Material(
                color: Get.theme.scaffoldBackgroundColor,
                child: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
