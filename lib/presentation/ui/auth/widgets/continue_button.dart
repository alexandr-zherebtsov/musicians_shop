import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/widgets/app_button.dart';

class AuthContinueButton extends StatelessWidget {
  final ResponsiveScreen screen;
  final String title;
  final void Function() onTap;

  const AuthContinueButton({
    Key? key,
    required this.screen,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: AppStyles.constraints,
        child: Padding(
          padding: screen.isPhone ? const EdgeInsets.only(
            top: 6.0,
            bottom: 8.0,
          ) : const EdgeInsets.only(
            top: 6.0,
            bottom: 22.0,
          ),
          child: AppButton(
            title: title,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
