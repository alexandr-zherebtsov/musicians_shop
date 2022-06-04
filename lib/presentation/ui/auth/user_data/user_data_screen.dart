import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/user_data/user_data_controller.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/auth_header.dart';
import 'package:musicians_shop/shared/constants/reg_exp.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
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
            body: SafeArea(
              child: controller.screenLoader ? const AppProgress() : Column(
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
                          constraints: AppStyles.constraints,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppTextField(
                                controller: controller.firstNameTC,
                                hint: StringsKeys.firstName.tr,
                                maxLines: 1,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  left: 22,
                                  right: 22,
                                ),
                                onSubmitted: (_) => controller.done(),
                              ),
                              AppTextField(
                                controller: controller.lastNameTC,
                                hint: StringsKeys.lastName.tr,
                                maxLines: 1,
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  left: 22,
                                  right: 22,
                                  bottom: 30,
                                ),
                                onSubmitted: (_) => controller.done(),
                              ),
                              AppTextField(
                                controller: controller.phoneNumberTC,
                                hint: StringsKeys.phoneNumber.tr,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                prefix: '+',
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(16),
                                  FilteringTextInputFormatter.allow(AppRegExp.numRegExp),
                                ],
                                onSubmitted: (_) => controller.done(),
                              ),
                              AppTextField(
                                controller: controller.cityTC,
                                hint: StringsKeys.city.tr,
                                maxLines: 1,
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  left: 22,
                                  right: 22,
                                  bottom: 6,
                                ),
                                onSubmitted: (_) => controller.done(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
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
