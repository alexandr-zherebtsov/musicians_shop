import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/profile/user_profile/user_profile_controller.dart';
import 'package:musicians_shop/presentation/ui/profile/widgets/profile_header.dart';
import 'package:musicians_shop/presentation/ui/profile/widgets/user_info_item.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';
import 'package:musicians_shop/shared/utils/utils.dart';
import 'package:musicians_shop/shared/widgets/app_bar_widget.dart';
import 'package:musicians_shop/shared/widgets/app_error_widget.dart';
import 'package:musicians_shop/shared/widgets/app_progress.dart';

class UserProfileScreen extends GetResponsiveView<UserProfileController> {
  UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return Scaffold(
      appBar: AppBarWidget(
        title: StringsKeys.profile.tr,
        back: Get.back,
      ),
      body: GetBuilder<UserProfileController>(
        autoRemove: false,
        builder: (_) {
          if (controller.screenLoader) {
            return const AppProgress();
          } else if (controller.screenError) {
            return const AppErrorWidget();
          } else {
            return RefreshIndicator(
              onRefresh: controller.onInit,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHeader(
                          screen: screen,
                          userIcon: controller.user?.photo,
                          firstName: controller.user?.firstName,
                          lastName: controller.user?.lastName,
                          city: controller.user?.city,
                        ),
                        UserInfoItem(
                          title: StringsKeys.email.tr,
                          data: controller.user?.email,
                        ),
                        UserInfoItem(
                          title: StringsKeys.phoneNumber.tr,
                          data: formatPhone(controller.user?.phone),
                        ),
                        UserInfoItem(
                          title: StringsKeys.aboutYourself.tr,
                          data: controller.user?.aboutYourself,
                        ),
                        UserInfoItem(
                          title: StringsKeys.favoriteInstruments.tr,
                          data: getInstrumentTypesString(controller.user?.favoriteInstruments ?? []),
                        ),
                        UserInfoItem(
                          title: StringsKeys.favoriteBrands.tr,
                          data: getBrandsString(controller.user?.favoriteBrands ?? []),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
