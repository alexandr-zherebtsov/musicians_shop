import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAddButton extends StatelessWidget {
  final ResponsiveScreen screen;
  final void Function() onPressed;

  const CreateAddButton({
    Key? key,
    required this.screen,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
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
              elevation: 0.5,
              focusElevation: 0.8,
              highlightElevation: 0.8,
              disabledElevation: 0.5,
              padding: EdgeInsets.zero,
              color: Get.theme.primaryColor,
              onPressed: onPressed,
              child: const Center(
                child: Icon(
                  Icons.add,
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
