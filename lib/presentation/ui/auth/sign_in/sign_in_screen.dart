import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/sign_in/sign_in_controller.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/auth_header.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/continue_button.dart';
import 'package:musicians_shop/presentation/widgets/app_progress.dart';
import 'package:musicians_shop/presentation/widgets/app_text_field.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class SignInScreen extends GetResponsiveView<SignInController> {
  SignInScreen({super.key});

  @override
  Widget builder() {
    return GetBuilder<SignInController>(
      init: Get.find<SignInController>(),
      builder: (SignInController controller) {
        return GestureDetector(
          onTap: controller.unFocus,
          child: Scaffold(
            body: SafeArea(
              child: controller.screenLoader
                  ? const AppProgress()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthHeader(
                          title: StringsKeys.signUp.tr,
                          screen: screen,
                        ),
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: AppStyles.constraints,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppTextField(
                                      controller: controller.emailTC,
                                      hint: StringsKeys.email.tr,
                                      maxLines: 1,
                                      suffixIcon: AppIcons.mail,
                                      keyboardType: TextInputType.emailAddress,
                                      onSubmitted: (_) => controller.done(),
                                    ),
                                    AppTextField(
                                      controller: controller.passwordTC,
                                      hint: StringsKeys.password.tr,
                                      maxLines: 1,
                                      suffixIcon: AppIcons.lock,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      padding: const EdgeInsets.only(
                                        top: 30,
                                        left: 22,
                                        right: 22,
                                        bottom: 10,
                                      ),
                                      onSubmitted: (_) => controller.done(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        MainContinueButton(
                          screen: screen,
                          title: StringsKeys.continueText.tr,
                          onTap: controller.done,
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
