import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/widgets/app_button.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class MainContinueButton extends StatelessWidget {
  final ResponsiveScreen screen;
  final String title;
  final VoidCallback onTap;

  const MainContinueButton({
    required this.screen,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: AppStyles.constraints,
        child: Padding(
          padding: screen.isPhone
              ? const EdgeInsets.only(
                  top: 6,
                  bottom: 8,
                )
              : const EdgeInsets.only(
                  top: 6,
                  bottom: 22,
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
