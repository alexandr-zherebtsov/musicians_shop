import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/user_data/user_data_controller.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/auth_header.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/auth_text_field.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/widgets/app_button.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';

class UserDataScreen extends GetResponsiveView<UserDataController> {
  UserDataScreen({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return GetBuilder<UserDataController>(
      init: UserDataController(),
      builder: (UserDataController controller) {
        return GestureDetector(
          onTap: controller.unFocus,
          child: Scaffold(
            body: controller.screenLoader ? const AppProgress() : SafeArea(
              child: Column(
                children: [
                  AuthHeader(
                    title: StringsKeys.informationAboutYourself.tr,
                    screen: screen,
                    hideBack: true,
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
                            AuthTextField(
                              controller: controller.firstName,
                              hint: StringsKeys.firstName.tr,
                            ),
                            AuthTextField(
                              controller: controller.lastName,
                              hint: StringsKeys.lastName.tr,
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
          ),
        );
      },
    );
  }
}
