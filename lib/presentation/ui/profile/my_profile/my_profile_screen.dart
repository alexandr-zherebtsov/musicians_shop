import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musicians_shop/presentation/ui/profile/my_profile/my_profile_controller.dart';
import 'package:musicians_shop/presentation/ui/profile/widgets/profile_header.dart';
import 'package:musicians_shop/presentation/ui/profile/widgets/user_info_item.dart';
import 'package:musicians_shop/presentation/ui/profile/widgets/user_photo_dialog.dart';
import 'package:musicians_shop/presentation/widgets/app_button.dart';
import 'package:musicians_shop/presentation/widgets/app_error_widget.dart';
import 'package:musicians_shop/presentation/widgets/app_progress.dart';
import 'package:musicians_shop/presentation/widgets/app_text_button.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

class MyProfileScreen extends GetView<MyProfileController> {
  final ResponsiveScreen screen;

  const MyProfileScreen({
    required this.screen,
    super.key,
  });

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
                RefreshIndicator.adaptive(
                  onRefresh: controller.onInit,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHeader(
                          screen: screen,
                          userIcon: controller.user?.photo,
                          firstName: controller.user?.firstName,
                          lastName: controller.user?.lastName,
                          city: controller.user?.city,
                          onTapIcon: () => showAvatarDialog(
                            isBottomSheet: screen.isPhone,
                            changeWeb: controller.changeAvatarWeb,
                            galleryMobile: () => controller.changeAvatarMobile(
                              ImageSource.gallery,
                            ),
                            cameraMobile: () => controller.changeAvatarMobile(
                              ImageSource.camera,
                            ),
                            delete: (controller.user?.photo ?? '').isEmpty
                                ? null
                                : controller.deleteAvatar,
                          ),
                          onTapEdit: controller.onTapEdit,
                        ),
                        UserInfoItem(
                          title: StringsKeys.email.tr,
                          data: controller.user?.email,
                        ),
                        UserInfoItem(
                          title: StringsKeys.phoneNumber.tr,
                          data: MainUtils.formatPhone(controller.user?.phone),
                        ),
                        UserInfoItem(
                          title: StringsKeys.aboutYourself.tr,
                          data: controller.user?.aboutYourself,
                        ),
                        UserInfoItem(
                          title: StringsKeys.favoriteInstruments.tr,
                          data: MainUtils.getInstrumentTypesString(
                              controller.user?.favoriteInstruments ?? []),
                        ),
                        UserInfoItem(
                          title: StringsKeys.favoriteBrands.tr,
                          data: MainUtils.getBrandsString(
                              controller.user?.favoriteBrands ?? []),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 22,
                            left: 11,
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
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 16,
                  child: AppButton(
                    title: StringsKeys.signOut.tr,
                    onTap: controller.onTapSignOut,
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
