import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/profile/edit_profile/edit_profile_controller.dart';
import 'package:musicians_shop/shared/constants/reg_exp.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/widgets/app_bar_widget.dart';
import 'package:musicians_shop/shared/widgets/app_button.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:musicians_shop/shared/widgets/app_text_field.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.unFocus,
      child: Scaffold(
        appBar: AppBarWidget(
          title: StringsKeys.editProfile.tr,
        ),
        body: GetBuilder<EditProfileController>(
          autoRemove: false,
          builder: (_) {
            if (controller.screenLoader) {
              return const AppProgress();
            } else if (controller.screenError) {
              return const AppErrorWidget();
            } else {
              return Center(
                child: ConstrainedBox(
                  constraints: AppStyles.constraints,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                controller: controller.firstNameTC,
                                hint: StringsKeys.firstName.tr,
                                padding: const EdgeInsets.only(
                                  top: 30,
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
                                  FilteringTextInputFormatter.allow(AppRegExp.numRegExp),
                                ],
                              ),
                              AppTextField(
                                controller: controller.cityTC,
                                hint: StringsKeys.city.tr,
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  left: 22,
                                  right: 22,
                                  bottom: 80,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 16,
                          child: AppButton(
                            title: StringsKeys.save.tr,
                            onTap: controller.save,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
