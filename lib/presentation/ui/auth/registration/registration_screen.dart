import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/registration/registration_controller.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/auth_header.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/continue_button.dart';
import 'package:musicians_shop/presentation/widgets/app_progress.dart';
import 'package:musicians_shop/presentation/widgets/app_text_field.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class RegistrationScreen extends GetResponsiveView<RegistrationController> {
  RegistrationScreen({super.key});

  @override
  Widget builder() {
    return GetBuilder<RegistrationController>(
      init: Get.find<RegistrationController>(),
      builder: (RegistrationController controller) {
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
                          title: StringsKeys.createAnAccount.tr,
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
                                      keyboardType: TextInputType.emailAddress,
                                      suffixIcon: AppIcons.mail,
                                      onSubmitted: (_) => controller.done(),
                                    ),
                                    AppTextField(
                                      controller: controller.passwordTC,
                                      hint: StringsKeys.password.tr,
                                      maxLines: 1,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      suffixIcon: AppIcons.lock,
                                      obscureText: true,
                                      padding: const EdgeInsets.only(
                                        top: 30,
                                        left: 22,
                                        right: 22,
                                        bottom: 30,
                                      ),
                                      onSubmitted: (_) => controller.done(),
                                    ),
                                    AppTextField(
                                      controller: controller.repeatPasswordTC,
                                      hint: StringsKeys.repeatPassword.tr,
                                      maxLines: 1,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      suffixIcon: AppIcons.lock,
                                      obscureText: true,
                                      padding: const EdgeInsets.only(
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
