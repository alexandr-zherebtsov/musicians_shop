import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/auth/user_data/user_data_controller.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/auth_header.dart';
import 'package:musicians_shop/presentation/ui/auth/widgets/continue_button.dart';
import 'package:musicians_shop/shared/constants/reg_exp.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/widgets/app_field_header.dart';
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
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SafeArea(
                child: controller.screenLoader ? const AppProgress() : Column(
                  children: [
                    AuthHeader(
                      title: StringsKeys.informationAboutYourself.tr,
                      screen: screen,
                      hideBack: true,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Center(
                            child: SingleChildScrollView(
                              child: Center(
                                child: ConstrainedBox(
                                  constraints: AppStyles.constraints,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 140,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const AppFieldHeader(
                                          header: StringsKeys.firstName,
                                        ),
                                        AppTextField(
                                          controller: controller.firstNameTC,
                                          hint: StringsKeys.firstName.tr,
                                          maxLines: 1,
                                          onSubmitted: (_) => controller.done(),
                                        ),
                                        const AppFieldHeader(
                                          header: StringsKeys.lastName,
                                        ),
                                        AppTextField(
                                          controller: controller.lastNameTC,
                                          hint: StringsKeys.lastName.tr,
                                          maxLines: 1,
                                          onSubmitted: (_) => controller.done(),
                                        ),
                                        const AppFieldHeader(
                                          header: StringsKeys.phoneNumber,
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
                                        const AppFieldHeader(
                                          header: StringsKeys.city,
                                        ),
                                        AppTextField(
                                          controller: controller.cityTC,
                                          hint: StringsKeys.city.tr,
                                          maxLines: 1,
                                          onSubmitted: (_) => controller.done(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: MainContinueButton(
                              screen: screen,
                              title: StringsKeys.continueText.tr,
                              onTap: controller.done,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
