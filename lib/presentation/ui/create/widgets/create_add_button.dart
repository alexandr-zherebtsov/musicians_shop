import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/icons.dart';

class CreateAddButton extends StatelessWidget {
  final ResponsiveScreen screen;
  final VoidCallback onPressed;

  const CreateAddButton({
    required this.screen,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        width: screen.isPhone ? 70 : 100,
        height: screen.isPhone ? 70 : 100,
        child: Center(
          child: SizedBox(
            width: 70,
            height: 70,
            child: MaterialButton(
              height: 70,
              minWidth: 70,
              elevation: .5,
              focusElevation: .8,
              highlightElevation: .8,
              disabledElevation: .5,
              padding: EdgeInsets.zero,
              color: Get.theme.primaryColor,
              onPressed: onPressed,
              child: Center(
                child: Icon(
                  AppIcons.plus,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
