import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/sign_up/sign_up_controller.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/auth_header.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/widgets/app_button.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:musicians_shop/shared/widgets/app_text_field.dart';

class SignUpScreen extends GetResponsiveView<SignUpController> {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (SignUpController controller) {
        return GestureDetector(
          onTap: controller.unFocus,
          child: Scaffold(
            body: controller.screenLoader ? const AppProgress() : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: StringsKeys.signUp.tr,
                  screen: screen,
                ),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppTextField(
                            controller: controller.emailTC,
                            hint: StringsKeys.email.tr,
                            suffixIcon: Icons.mail,
                            keyboardType:TextInputType.emailAddress,
                          ),
                          AppTextField(
                            controller: controller.passwordTC,
                            hint: StringsKeys.password.tr,
                            suffixIcon: Icons.lock,
                            keyboardType:TextInputType.visiblePassword,
                            obscureText: true,
                            padding: const EdgeInsets.only(
                              top: 30,
                              left: 22,
                              right: 22,
                              bottom: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                    ),
                    child: Padding(
                      padding: screen.isPhone ? const EdgeInsets.only(
                        top: 6.0,
                        bottom: 8.0,
                      ) : const EdgeInsets.only(
                        top: 6.0,
                        bottom: 22.0,
                      ),
                      child: AppButton(
                        title: StringsKeys.continueText.tr,
                        onTap: controller.done,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
