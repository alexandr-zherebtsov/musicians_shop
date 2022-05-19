import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/user_data/user_data_controller.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/auth_header.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/widgets/app_button.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:musicians_shop/shared/widgets/app_text_field.dart';

class UserDataScreen extends GetResponsiveView<UserDataController> {
  UserDataScreen({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return GetBuilder<UserDataController>(
      autoRemove: false,
      builder: (_) {
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
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 600,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppTextField(
                                controller: controller.firstNameTC,
                                hint: StringsKeys.firstName.tr,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  left: 22,
                                  right: 22,
                                ),
                              ),
                              AppTextField(
                                controller: controller.lastNameTC,
                                hint: StringsKeys.lastName.tr,
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  left: 22,
                                  right: 22,
                                  bottom: 30,
                                ),
                              ),
                              AppTextField(
                                controller: controller.phoneNumberTC,
                                hint: StringsKeys.phoneNumber.tr,
                                keyboardType: TextInputType.number,
                                prefix: '+',
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(16),
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                ],
                              ),
                              AppTextField(
                                controller: controller.cityTC,
                                hint: StringsKeys.city.tr,
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  left: 22,
                                  right: 22,
                                  bottom: 6,
                                ),
                              ),
                            ],
                          ),
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
