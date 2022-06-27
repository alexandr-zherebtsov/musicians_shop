import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/widgets/app_back_button.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final ResponsiveScreen screen;
  final bool hideBack;

  const AuthHeader({
    Key? key,
    required this.title,
    required this.screen,
    this.hideBack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Offstage(
            offstage: hideBack,
            child: Padding(
              padding: screen.isPhone ? const EdgeInsets.only(
                top: 6,
                left: 8,
              ) : const EdgeInsets.only(
                top: 12,
                left: 8,
              ),
              child: AppBackButton(
                back: Get.back,
              ),
            ),
          ),
          Padding(
            padding: screen.isPhone ? const EdgeInsets.only(
              top: 10,
              left: 22,
              right: 22,
              bottom: 2,
            ) : const EdgeInsets.only(
              top: 20,
              left: 22,
              right: 22,
              bottom: 4,
            ),
            child: screen.isPhone ? _buildTitle() : Center(
              child: _buildTitle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Get.theme.textTheme.headline1,
    );
  }
}
