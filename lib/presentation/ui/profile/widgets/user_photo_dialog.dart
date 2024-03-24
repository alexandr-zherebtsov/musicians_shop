import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/widgets/divider_widget.dart';
import 'package:musicians_shop/shared/localization/keys.dart';
import 'package:musicians_shop/shared/styles/icons.dart';
import 'package:musicians_shop/shared/styles/styles.dart';
import 'package:musicians_shop/shared/utils/utils.dart';

void showAvatarDialog({
  required final bool isBottomSheet,
  required final VoidCallback changeWeb,
  required final VoidCallback galleryMobile,
  required final VoidCallback cameraMobile,
  required final VoidCallback? delete,
}) {
  isBottomSheet
      ? showAvatarBottomSheet(
          changeWeb: changeWeb,
          galleryMobile: galleryMobile,
          cameraMobile: cameraMobile,
          delete: delete,
        )
      : showAvatarAlertDialog(
          changeWeb: changeWeb,
          galleryMobile: galleryMobile,
          cameraMobile: cameraMobile,
          delete: delete,
        );
}

void showAvatarAlertDialog({
  required final VoidCallback changeWeb,
  required final VoidCallback galleryMobile,
  required final VoidCallback cameraMobile,
  required final VoidCallback? delete,
}) {
  Get.dialog(
    AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
      ),
      content: UserPhotoDialog(
        changeWeb: changeWeb,
        galleryMobile: galleryMobile,
        cameraMobile: cameraMobile,
        delete: delete,
        dialog: true,
      ),
    ),
  );
}

void showAvatarBottomSheet({
  required final VoidCallback changeWeb,
  required final VoidCallback galleryMobile,
  required final VoidCallback cameraMobile,
  required final VoidCallback? delete,
}) {
  Get.bottomSheet(
    SingleChildScrollView(
      child: SafeArea(
        child: UserPhotoDialog(
          changeWeb: changeWeb,
          galleryMobile: galleryMobile,
          cameraMobile: cameraMobile,
          delete: delete,
          dialog: false,
        ),
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppStyles.fieldRadius),
        topRight: Radius.circular(AppStyles.fieldRadius),
      ),
    ),
    barrierColor: Colors.transparent,
    backgroundColor: Get.theme.colorScheme.background,
  );
}

class UserPhotoDialog extends StatelessWidget {
  final VoidCallback changeWeb;
  final VoidCallback galleryMobile;
  final VoidCallback cameraMobile;
  final VoidCallback? delete;
  final bool dialog;

  const UserPhotoDialog({
    required this.changeWeb,
    required this.galleryMobile,
    required this.cameraMobile,
    required this.delete,
    required this.dialog,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              bottom: 8,
            ),
            child: Text(
              StringsKeys.changeAvatar.tr,
              style: Get.theme.textTheme.titleLarge,
            ),
          ),
          dialog
              ? const SizedBox(
                  height: 10,
                )
              : const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: DividerWidget(),
                ),
          if (MainUtils.isWebAndroid || MainUtils.isMobileApp) ...[
            Material(
              color: Colors.transparent,
              child: ListTile(
                onTap: galleryMobile,
                leading: Icon(
                  AppIcons.gallery,
                  size: 20,
                  color: Get.theme.iconTheme.color,
                ),
                title: Text(
                  StringsKeys.chooseFromGallery.tr,
                  style: Get.theme.textTheme.bodyLarge,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: ListTile(
                onTap: cameraMobile,
                leading: Icon(
                  AppIcons.addPhoto,
                  size: 20,
                  color: Get.theme.iconTheme.color,
                ),
                title: Text(
                  StringsKeys.takePhoto.tr,
                  style: Get.theme.textTheme.bodyLarge,
                ),
              ),
            ),
          ] else
            Material(
              color: Colors.transparent,
              child: ListTile(
                onTap: changeWeb,
                leading: Icon(
                  AppIcons.addPhoto,
                  size: 20,
                  color: Get.theme.iconTheme.color,
                ),
                title: Text(
                  StringsKeys.newAvatar.tr,
                  style: Get.theme.textTheme.bodyLarge,
                ),
              ),
            ),
          Offstage(
            offstage: delete == null,
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                onTap: delete,
                leading: Icon(
                  AppIcons.delete,
                  size: 22,
                  color: Get.theme.iconTheme.color,
                ),
                title: Text(
                  StringsKeys.deleteAvatar.tr,
                  style: Get.theme.textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
