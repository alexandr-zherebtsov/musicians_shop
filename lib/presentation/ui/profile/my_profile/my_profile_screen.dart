import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/profile/my_profile/my_profile_controller.dart';
import 'package:musicians_shop/presentation/ui/profile/widgets/profile_header.dart';
import 'package:musicians_shop/presentation/ui/profile/widgets/user_info_item.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';
import 'package:musicians_shop/shared/widgets/app_button.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';
import 'package:musicians_shop/shared/widgets/app_text_button.dart';

class MyProfileScreen extends GetView<MyProfileController> {
  final ResponsiveScreen screen;

  const MyProfileScreen({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProfileController>(
      autoRemove: false,
      builder: (_) {
        if (controller.screenLoader) {
          return const AppProgress();
        } else if (controller.screenError) {
          return AppErrorWidget(
            refresh: controller.logOut,
          );
        } else {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileHeader(
                        screen: screen,
                        userIcon: controller.user?.photo,
                        firstName: controller.user?.name,
                        lastName: controller.user?.surname,
                        city: controller.user?.city,
                        onTapIcon: controller.onTapIcon,
                        onTapEdit: controller.onTapEdit,
                      ),
                      UserInfoItem(
                        title: StringsKeys.email.tr,
                        data: controller.user?.email,
                      ),
                      UserInfoItem(
                        title: StringsKeys.phoneNumber.tr,
                        data: formatPhone(controller.user?.phoneNumber),
                      ),
                      UserInfoItem(
                        title: StringsKeys.aboutYourself.tr,
                        data: formatPhone(controller.user?.aboutYourself),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 22,
                          left: 12,
                          bottom: 80,
                        ),
                        child: AppTextButton(
                          title: StringsKeys.deleteAccount.tr,
                          textColor: Colors.redAccent,
                          onTap: controller.onTapDeleteAccount,
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
                    title: StringsKeys.signOut.tr,
                    onTap: controller.logOut,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
