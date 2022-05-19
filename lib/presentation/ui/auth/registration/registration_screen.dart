import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/registration/registration_controller.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/auth_header.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/widgets/app_button.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:musicians_shop/shared/widgets/app_text_field.dart';

class RegistrationScreen extends GetResponsiveView<RegistrationController> {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return GetBuilder<RegistrationController>(
      init: RegistrationController(),
      builder: (RegistrationController controller) {
        return GestureDetector(
          onTap: controller.unFocus,
          child: Scaffold(
            body: controller.screenLoader ? const AppProgress() : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: StringsKeys.createAnAccount.tr,
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
                            keyboardType:TextInputType.emailAddress,
                            suffixIcon: Icons.mail,
                          ),
                          AppTextField(
                            controller: controller.passwordTC,
                            hint: StringsKeys.password.tr,
                            keyboardType:TextInputType.visiblePassword,
                            suffixIcon: Icons.lock,
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
